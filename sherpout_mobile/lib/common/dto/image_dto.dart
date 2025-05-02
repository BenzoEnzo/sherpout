class ImageDto {
  final String imagePath;

  ImageDto({
    required this.imagePath,
  });

  factory ImageDto.fromJson(Map<String, dynamic> json) {
    return ImageDto(
      imagePath: json['imagePath'] as String,
    );
  }
}
