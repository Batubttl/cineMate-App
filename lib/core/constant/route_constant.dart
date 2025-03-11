class RouteConstant {
  static const String home = '/';
  static const String search = '/search';
  static const String watchlist = '/watchlist';
  static const String favorites = '/favorites';

  static const String movieDetail = 'movie/:id';

  static String movieDetailPath(int id) => '/movie/$id';
}
