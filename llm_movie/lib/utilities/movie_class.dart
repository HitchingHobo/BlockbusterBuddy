class Movie {
  final String title;
  final String description;
  final String releaseYear;
  final String rating;
  final String posterPath;
  final String tmdbId;
  final List<Map<String, String>> streamInfo;
  final List genres;
  final List<String> keywords;

  Movie({
    required this.title,
    required this.description,
    required this.releaseYear,
    required this.rating,
    required this.posterPath,
    required this.tmdbId,
    required this.streamInfo,
    required this.genres,
    required this.keywords,
  });
}
