class ImageUrlDto {
  final String url;

  ImageUrlDto({
    required this.url,
  });

  factory ImageUrlDto.fromJson(Map<String, dynamic> json) {
    return ImageUrlDto(
      url: json['url'] as String,
    );
  }
}