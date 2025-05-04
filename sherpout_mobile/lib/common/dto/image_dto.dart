class ImageDto {
  final String name;

  ImageDto({
    required this.name,
  });

  factory ImageDto.fromJson(Map<String, dynamic> json) {
    return ImageDto(
      name: json['name'] as String,
    );
  }
}
