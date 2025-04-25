import 'package:sherpoutmobile/common/dto/translated_string_dto.dart';

import 'exercise_difficulty.dart';
import 'image_dto.dart';
import 'muscle.dart';

class ExerciseListDto {
  final int id;
  final TranslatedStringDto name;
  final ExerciseDifficulty difficulty;
  final Muscle targetMuscle;
  final Set<Muscle>? supportMuscles;
  final int likesNumber;
  final ImageDto? cover;

  ExerciseListDto({
    required this.id,
    required this.name,
    required this.difficulty,
    required this.targetMuscle,
    this.supportMuscles,
    required this.likesNumber,
    this.cover,
  });

  factory ExerciseListDto.fromJson(Map<String, dynamic> json) {
    return ExerciseListDto(
      id: json['id'] as int,
      name: TranslatedStringDto.fromJson(json['name']),
      difficulty: ExerciseDifficulty.fromName(json['difficulty'])!,
      targetMuscle: Muscle.fromName(json['targetMuscle'])!,
      supportMuscles: (json['supportMuscles'] as List?)
          ?.map((e) => Muscle.fromName(e))
          .whereType<Muscle>()
          .toSet(),
      likesNumber: json['likesNumber'] as int,
      // cover: json['cover'] != null ? ImageDto.fromJson(json['cover']) : null,
    );
  }
}
