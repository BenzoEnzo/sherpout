import 'package:sherpoutmobile/common/dto/translated_string_dto.dart';

class ExerciseSelectDTO {
  final int id;
  final TranslatedStringDto? name;

  ExerciseSelectDTO({
    required this.id,
    this.name,
  });

  factory ExerciseSelectDTO.fromJson(Map<String, dynamic> json) {
    return ExerciseSelectDTO(
      id: json['id'] as int,
      name: json['name'] != null
          ? TranslatedStringDto.fromJson(json['name'] as Map<String, dynamic>)
          : null,
    );
  }
}