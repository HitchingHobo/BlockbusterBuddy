import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:llm_movie/api/prompt_test_text.dart';
import 'package:llm_movie/secrets.dart' as config;
import 'package:llm_movie/utilities/genre_id.dart';
import 'package:llm_movie/utilities/data_classes.dart';
import 'package:dart_openai/dart_openai.dart';
import 'dart:convert';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

final Dio dio = Dio();
String bearerKey = config.movieBearerKey;
String streamKey = config.rapidAPIKey;
String openAiKey = config.openAiKey;

class FilmApi {
  final Dio dio;

  FilmApi(this.dio);

  // Movie api-call
  Future<List<Movie>> fetchMovies(String query) async {
    dio.options.headers['Authorization'] = 'Bearer $bearerKey';
    dio.options.headers['Accept'] = 'application/json';

    Response response = await dio.get(
      'https://api.themoviedb.org/3/search/movie',
      queryParameters: {
        'query': query,
        'include_adult': false,
        'language': 'en-US',
        'page': 1,
      },
    );

    if (kDebugMode) {
      print('Movie API call sent');
    }

    List<Movie> movies = [];
    List<dynamic> results = response.data['results'];

    // Minskar resultaten för att begärnsa api-anrop, varje resultat kräver två till anrop
    for (var result in results.take(8)) {
      List<int> genreIds = (result['genre_ids'] as List<dynamic>).cast<int>();

      List<String> genreNames =
          genreIds.map((genreId) => genreMap[genreId] ?? "Unknown").toList();

      List<String> keywords = await fetchKeywords(result['id']);

      Map<String, List<String>> credits = await fetchCredits(result['id']);
      List<String> actors = credits['actors'] ?? [];
      List<String> director = credits['director'] ?? [];

      if (result['poster_path'] == null) {
        result['poster_path'] =
            'https://www.publicdomainpictures.net/pictures/280000/velka/not-found-image-15383864787lu.jpg';
      } else {
        result['poster_path'] =
            'https://image.tmdb.org/t/p/w600_and_h900_bestv2${result['poster_path']}';
      }

      movies.add(Movie(
        title: result['title'],
        description: result['overview'],
        releaseDate: result['release_date'].toString(),
        rating: result['vote_average'].toString(),
        posterPath: result['poster_path'].toString(),
        tmdbId: result['id'].toString(),
        streamInfo: [],
        genres: genreNames,
        keywords: keywords,
        actors: actors,
        director: director,
        tweakGenres: [
          'Action',
          'Adventure',
          'Animation',
          'Comedy',
          'Crime',
          'Documentary',
          'Drama',
          'Family',
          'Fantasy',
          'History',
          'Horror',
          'Music',
          'Mystery',
          'Romance',
          'Science Fiction',
          'TV Movie',
          'Thriller',
          'War',
          'Western',
        ],
      ));
    }
    return movies;
  }

  // Credits api-call
  Future<Map<String, List<String>>> fetchCredits(int movieID) async {
    dio.options.headers['Authorization'] = 'Bearer $bearerKey';
    dio.options.headers['Accept'] = 'application/json';

    Response response = await dio.get(
      'https://api.themoviedb.org/3/movie/$movieID/credits?language=en-US',
    );

    if (kDebugMode) {
      //print('Credits API call sent');
    }

    List<String> actors = [];
    List<dynamic> cast = response.data['cast'];

    for (var actor in cast.take(6)) {
      actors.add(actor['name'].toString());
    }

// Kanske inte behövs
    // List<String> director = [];
    // List<dynamic> crew = response.data['crew'];

    // for (var person in crew) {
    //   if (person['job'] == 'Director') {
    //     director.add(person['name'].toString());
    //   }
    // }

    List<String> director = [];
    return {
      'actors': actors,
      'director': director,
    };
  }

  // Keywords api-call
  Future<List<String>> fetchKeywords(int movieId) async {
    dio.options.headers['Authorization'] = 'Bearer $bearerKey';
    dio.options.headers['Accept'] = 'application/json';

    Response response = await dio.get(
      'https://api.themoviedb.org/3/movie/$movieId/keywords',
    );

    if (kDebugMode) {
      //print('Keywords API call sent');
    }

    List<String> keywords = (response.data['keywords'] as List<dynamic>)
        .map((keyword) => keyword['name'].toString())
        .toList();

    return keywords;
  }
}

// Stream info api-call
Future<List<Map<String, String>>> fetchStreamInfo(String movieId) async {
  Dio dio = Dio();
  List<Map<String, String>> result = [];

  try {
    Response response = await dio.get(
      'https://streaming-availability.p.rapidapi.com/get?output_language=en&tmdb_id=movie%2F$movieId',
      options: Options(
        headers: {
          'X-RapidAPI-Host': 'streaming-availability.p.rapidapi.com',
          'X-RapidAPI-Key': streamKey
        },
      ),
    );
    Map<String, dynamic> jsonResponse = response.data;

    Map<String, dynamic> streamingInfo =
        jsonResponse['result']['streamingInfo'];

    if (streamingInfo['se'] == null) {
      if (kDebugMode) {
        print('No streaming services found');
      }
    } else {
      List se = streamingInfo['se'];

      Set<String> uniqueItems = {};

      for (Map<String, dynamic> serviceInfo in se) {
        String service = serviceInfo['service'];
        String streamingType = serviceInfo['streamingType'];

        String combination = '$service|$streamingType';

        if (!uniqueItems.contains(combination)) {
          uniqueItems.add(combination);

          result.add({'service': service, 'streamingType': streamingType});
        }
      }
    }
  } catch (error) {
    if (kDebugMode) {
      print('No items');
    }
  }
  return result;
}

Future<List<dynamic>> fetchRecommendations(String prompt) async {
  OpenAI.requestsTimeOut = const Duration(seconds: 60);
  OpenAI.apiKey = openAiKey;
  // OpenAI.showResponsesLogs = true;
  // OpenAI.showLogs = true;

  final systemMessage = OpenAIChatCompletionChoiceMessageModel(
    content: [
      OpenAIChatCompletionChoiceMessageContentItemModel.text(
        PrompText().assistantInstructions,
      ),
    ],
    role: OpenAIChatMessageRole.assistant,
  );

  final userMessage = OpenAIChatCompletionChoiceMessageModel(
    content: [
      OpenAIChatCompletionChoiceMessageContentItemModel.text(
        prompt,
      ),
    ],
    role: OpenAIChatMessageRole.user,
  );

  final requestMessages = [
    systemMessage,
    userMessage,
  ];

  OpenAIChatCompletionModel chatCompletion = await OpenAI.instance.chat.create(
    model: "gpt-3.5-turbo-1106",
    responseFormat: {"type": "json_object"},
    seed: 6,
    messages: requestMessages,
    temperature: 1.2,
    maxTokens: 700,
  );

  if (kDebugMode) {
    print('OpenAI API call sent');
    // print(chatCompletion.choices.first.message);
    // print(chatCompletion.usage.promptTokens);
    // print(chatCompletion.id);
  }
  Map<String, dynamic> mappedchat = chatCompletion.choices[0].message.toMap();
  String jsonString = mappedchat['content'][0]['text'];

  Map<String, dynamic> responseMap = jsonDecode(jsonString);

  List<dynamic> recommendationList = responseMap['movies'];

  // for (Map<String, dynamic> movie in moviesList) {
  //   String title = movie['title'];
  //   int releaseYear = movie['release_year'];
  //   String explanation = movie['explanation'];
  // }

  return recommendationList;
}
