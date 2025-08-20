import 'package:sherpoutmobile/common/dto/training_plan_exercise_dto.dart';

class TrainingPlanDayDTO {
  int? id;
  int? number;
  List<TrainingPlanExerciseDTO>? exercises;

  TrainingPlanDayDTO({
    this.id,
    this.number,
    this.exercises,
  });

  factory TrainingPlanDayDTO.fromJson(Map<String, dynamic> json) {
    return TrainingPlanDayDTO(
      id: json['id'] != null ? json['id'] as int : null,
      number: json['number'] != null ? json['number'] as int : null,
      exercises: (json['exercises'] as List?)
          ?.map((e) => TrainingPlanExerciseDTO.fromJson(e))
          .whereType<TrainingPlanExerciseDTO>()
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (number != null) 'number': number,
      if (exercises != null)
        'exercises': exercises!.map((e) => e.toJson()).toList(),
    };
  }
}