class FavoriteResponse {
  final int page;
  final List<FavoriteItem> results;
  final int totalPages;
  final int totalResults;
  FavoriteResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '': toMap(),
      'results': results.map((x) => toMap()).toList(),
      'totalPages': totalPages,
      'totalResults': totalResults,
    };
  }

  factory FavoriteResponse.fromJson(Map<String, dynamic> json) {
    return FavoriteResponse(
      page: json['page'] ?? 0,
      results: (json['results'] as List<dynamic>?)
              ?.map((e) => FavoriteItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      totalPages: json['total_pages'] ?? 0,
      totalResults: json['total_results'] ?? 0,
    );
  }
}

class FavoriteItem {
  final int id;
  final String title;
  final String? posterPath;
  final String? backdropPath;
  final double? voteAverage;
  final String mediaType;

  FavoriteItem(
      {required this.id,
      required this.title,
      this.posterPath,
      this.backdropPath,
      this.voteAverage,
      required this.mediaType});
  factory FavoriteItem.fromJson(Map<String, dynamic> json) {
    final title = json['title'] ?? json['name'] ?? '';
    final mediaType = json['media_type'] ?? 'movie';

    return FavoriteItem(
      id: json['id'] ?? 0,
      title: title,
      posterPath: json['poster_path'],
      backdropPath: json['backdrop_path'],
      voteAverage: (json['vote_average'] ?? 0.0).toDouble(),
      mediaType: mediaType,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'poster_path': posterPath,
      'backdrop_path': backdropPath,
      'vote_average': voteAverage,
      'media_type': mediaType,
    };
  }
}
