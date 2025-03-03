class Movie {
  int? page ;
  List <MovieResults>? results ; 
  int totalPages ;
  int totalResult ;

  Movie(
    {
      this.page, this.results, required this.totalPages, required this.totalResult
    }
  ) ;
}

class MovieResults {
  bool adult ;
  String backdropPath;
  List<int>? genreIds ;
  int id ;
  String originalLanguage ;
  String originalTitle ;
  String overview ;
  double popularity ; 
  String posterPath ;
  String releaseDate ;
  String title ; 
  bool? video ;
  double? voteAverage ;
  int? voteCount ; 

  MovieResults (
    {
      required this.adult, required this.backdropPath, this.genreIds, required this.id,  required this.originalLanguage, required  this.originalTitle, required this.overview, required this.popularity, required this.posterPath, required this.releaseDate, required this.title, this.video, this.voteCount,this.voteAverage
    }
  ) ;
}