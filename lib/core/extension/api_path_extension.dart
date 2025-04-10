extension ApiPathExtension on String {
  String withMovieId(int movieId) {
    return replaceAll('{movie_id}', movieId.toString());
  }

  String withAccountId(String accountId) {
    return replaceAll('{account_id}', accountId);
  }

  String withGenreId(int genreId) {
    return '$this?with_genres=$genreId';
  }
}
