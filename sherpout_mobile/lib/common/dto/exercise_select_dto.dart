import 'package:sherpoutmobile/common/dto/translated_string_dto.dart';
import 'image_dto.dart';

class ExerciseSelectDTO {
  final int id;
  final ImageDto? cover;
  final TranslatedStringDto? name;

  ExerciseSelectDTO({
    required this.id,
    this.cover,
    this.name,
  });

  factory ExerciseSelectDTO.fromJson(Map<String, dynamic> json) {
    return ExerciseSelectDTO(
      id: json['id'] as int,
      cover: json['cover'] != null ? ImageDto.fromJson(json['cover']) : null,
      name: json['name'] != null
          ? TranslatedStringDto.fromJson(json['name'] as Map<String, dynamic>)
          : null,
    );
  }
}