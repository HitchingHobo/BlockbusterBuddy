import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:llm_movie/secrets.dart' as config;
import 'package:llm_movie/utilities/movie_class.dart';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

final Dio dio = Dio();
String bearerKey = config.movieBearerKey;
String streamKey = config.rapidAPIKey;

class FilmApi {
  final Dio dio;

  FilmApi(this.dio);

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
      print('Api call sent');
      print(response.data['results'].length);
      print(response);
    }

    List<Movie> movies = [];
    for (var result in response.data['results']) {
      movies.add(Movie(
        title: result['title'],
        description: result['overview'],
        releaseYear: result['release_date'].toString(),
        rating: result['vote_average'].toString(),
        posterPath:
            'https://image.tmdb.org/t/p/w600_and_h900_bestv2${result['poster_path']}',
        tmdbId: result['id'].toString(),
        streamInfo: [],
        genres: result['genre_ids'],
      ));
    }

    return movies;
  }

  // final Movie movie = Movie(
  //   title: randomMovie['title'],
  //   description: randomMovie['overview'],
  //   releaseYear: randomMovie['release_date'].toString().substring(0, 4),
  //   rating: randomMovie['vote_average'].toString(),
  //   posterPath:
  //       'https://image.tmdb.org/t/p/w600_and_h900_bestv2${randomMovie['poster_path']}',
  //   tmdbId: randomMovie['id'].toString(),
  //   streamInfo: [],
  //   //streamInfo: await fetchStreamInfo(randomMovie['id'].toString()),
  //   genres: [],
  // );
  // return movie;
}

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
