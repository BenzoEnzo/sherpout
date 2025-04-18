class ImageDto {
  final String url;

  ImageDto({
    required this.url,
  });

  factory ImageDto.fromJson(Map<String, dynamic> json) {
    return ImageDto(
      url: json['url'] as String,
    );
  }
}
