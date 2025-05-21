import 'package:sherpoutmobile/common/dto/translated_string_dto.dart';
import 'image_dto.dart';

class ExerciseSelectDTO {
  final int id;
  final TranslatedStringDto name;
  final ImageDto? cover;

  ExerciseSelectDTO({
    required this.id,
    required this.name,
    this.cover
  });

  factory ExerciseSelectDTO.fromJson(Map<String, dynamic> json) {
    return ExerciseSelectDTO(
      id: json['id'] as int,
      name: TranslatedStringDto.fromJson(json['name'] as Map<String, dynamic>),
      cover: json['cover'] != null ? ImageDto.fromJson(json['cover']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
    };
  }
}