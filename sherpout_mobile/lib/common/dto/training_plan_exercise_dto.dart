import 'exercise_select_dto.dart';

class TrainingPlanExerciseDTO {
  int? id;
  ExerciseSelectDTO? exercise;
  int? sets;

  TrainingPlanExerciseDTO({
    this.id,
    this.exercise,
    this.sets,
  });

  factory TrainingPlanExerciseDTO.fromJson(Map<String, dynamic> json) {
    return TrainingPlanExerciseDTO(
      id: json['id'] != null ? json['id'] as int : null,
      exercise: ExerciseSelectDTO.fromJson(json['exercise']),
      sets: json['sets'] != null ? json['sets'] as int : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (exercise != null) 'exercise': exercise!.toJson(),
      if (sets != null) 'sets': sets,
    };
  }
}