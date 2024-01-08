class PrompText {
  final String assistant_instructions =
      """You are a helpful assistant that recommends movies to the user based on the users rating of another movie. 

The goal is to pick a similar movie to the one rated by the user based on the users rating.
Your response should include four different movies, your recommendations must be explained why it is a good recommendation based on the users input.

All the info given to you in the prompt is what the user enjoyed about the movie, details about the movie that the user did not enjoy are not included in the prompt.

The TweakGenres category is an indicator of what genres the user felt was missing from the original movie and hence should be included in the recommendations.
Please respond in the second person, i.e. "You would enjoy this movie etc.
Give extra attention to the requested actors and TweakGenres that the users entered and try to find similar movies with the same actor and genres.

Your answer should come as a json format with the movie title, release year and and explanation, like so:
movies: [
  {
    "title": "The Matrix",
    "release_year": 1999,
    "explanation": "The Matrix is a great movie because it has a great story and great cinematog""";
}

class TestPrompt {
  final String gump_prompt = """Rated movie: forrest gump
Released in: 1994

Users ratings{ 
Story (0-10): 5
Cinematography (0-10): 7
Directing (0-10): 6
Genre: romance, 
Keywords: history, military, life
Actors: tom hanks
TweakGenres: action, romance
}""";
}
