enum MediaType {
  movie('movie'),
  tv('tv');

  final String value;
  const MediaType(this.value);

  factory MediaType.fromString(String value) {
    return MediaType.values.firstWhere(
      (type) => type.value == value,
      orElse: () => MediaType.movie,
    );
  }
}
