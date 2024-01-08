class Movie {
  final String title;
  final String description;
  final String releaseDate;
  final String rating;
  final String posterPath;
  final String tmdbId;
  final List<Map<String, String>> streamInfo;
  final List genres;
  final List<String> keywords;
  final List<String> actors;
  final List<String> director;
  final List<String> tweakGenres;
  String? explanation;

  Movie({
    required this.title,
    required this.description,
    required this.releaseDate,
    required this.rating,
    required this.posterPath,
    required this.tmdbId,
    required this.streamInfo,
    required this.genres,
    required this.keywords,
    required this.actors,
    required this.director,
    required this.tweakGenres,
  });
}

// Används inte (än)
class Actor {
  final String name;
  final String character;
  final String profilePath;

  Actor({
    required this.name,
    required this.character,
    required this.profilePath,
  });
}

class Llmprompt {
  final String title;
  final String releaseYear;
  final int story;
  final int cinematography;
  final int directing;
  final List<String> genres;
  final List<String> keywords;
  final List<String> actors;
  final List<String> tweakGenres;

  Llmprompt({
    required this.title,
    required this.releaseYear,
    required this.story,
    required this.cinematography,
    required this.directing,
    required this.genres,
    required this.keywords,
    required this.actors,
    required this.tweakGenres,
  });

  String createPrompt() {
    return '{'
        ' Title: $title,'
        ' Release Year: $releaseYear,'
        ' User Ratings {'
        ' Story (0-10): $story,'
        ' Cinematography (0-10): $cinematography,'
        ' Directing (0-10): $directing,'
        ' Genres: $genres,'
        ' Keywords: $keywords,'
        ' Actors: $actors,'
        ' TweakGenres: $tweakGenres'
        '}}';
  }
}
