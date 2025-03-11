import 'package:equatable/equatable.dart';

class GenreResponse {
  List<GenreModel> genres;
  GenreResponse({
    required this.genres,
  });

  factory GenreResponse.fromJson(Map<String, dynamic> json) {
    return GenreResponse(
      genres: (json['genres'] as List<dynamic>?)
              ?.map((e) => GenreModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}

class GenreModel extends Equatable {
  final int id;
  final String name;

  const GenreModel({required this.id, required this.name});

  factory GenreModel.fromJson(Map<String, dynamic> json) {
    return GenreModel(
      id: json['id'] as int,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  @override
  List<Object?> get props => [id, name];
}
