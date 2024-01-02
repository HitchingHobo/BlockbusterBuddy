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
  });
}
