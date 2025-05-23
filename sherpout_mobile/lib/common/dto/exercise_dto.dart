import 'package:sherpoutmobile/common/dto/exercise_equipment.dart';
import 'package:sherpoutmobile/common/dto/exercise_list_dto.dart';
import 'package:sherpoutmobile/common/dto/translated_string_dto.dart';

import 'exercise_difficulty.dart';
import 'image_dto.dart';
import 'muscle.dart';

class ExerciseDto {
  final int id;
  final TranslatedStringDto name;
  final TranslatedStringDto description;
  final ExerciseDifficulty difficulty;
  final Muscle targetMuscle;
  final Set<Muscle>? supportMuscles;
  final Set<ExerciseEquipment>? equipments;
  final int likesNumber;
  final ImageDto? cover;
  final Set<ImageDto>? images;

  ExerciseDto({
    required this.id,
    required this.name,
    required this.description,
    required this.difficulty,
    required this.targetMuscle,
    this.supportMuscles,
    this.equipments,
    required this.likesNumber,
    this.cover,
    this.images
  });

  ExerciseListDto toListDto() {
    return ExerciseListDto(
        id: id,
        name: name,
        difficulty: difficulty,
        targetMuscle: targetMuscle,
        supportMuscles: supportMuscles,
        likesNumber: likesNumber,
        cover: cover
    );
  }

  factory ExerciseDto.fromJson(Map<String, dynamic> json) {
    return ExerciseDto(
        id: json['id'] as int,
        name: TranslatedStringDto.fromJson(json['name']),
        description: TranslatedStringDto.fromJson(json['description']),
        difficulty: ExerciseDifficulty.fromName(json['difficulty'])!,
        targetMuscle: Muscle.fromName(json['targetMuscle'])!,
        supportMuscles: (json['supportMuscles'] as List?)
            ?.map((e) => Muscle.fromName(e))
            .whereType<Muscle>()
            .toSet(),
        equipments: (json['equipments'] as List?)
            ?.map((e) => ExerciseEquipment.fromName(e))
            .whereType<ExerciseEquipment>()
            .toSet(),
        likesNumber: json['likesNumber'] as int,
        cover: json['cover'] != null ? ImageDto.fromJson(json['cover']) : null,
        images: (json['images'] as List?)
            ?.map((image) => ImageDto.fromJson(image))
            .whereType<ImageDto>()
            .toSet());
  }
}