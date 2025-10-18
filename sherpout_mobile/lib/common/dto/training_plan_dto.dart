import 'package:sherpoutmobile/common/dto/training_plan_day_dto.dart';
import 'package:sherpoutmobile/common/dto/translated_string_dto.dart';

class TrainingPlanDTO {
  int? id;
  TranslatedStringDto? name;
  TranslatedStringDto? description;
  List<TrainingPlanDayDTO> days;

  TrainingPlanDTO({
    this.id,
    this.name,
    this.description,
    List<TrainingPlanDayDTO>? days,
  }) : days = days ?? [];

  factory TrainingPlanDTO.fromJson(Map<String, dynamic> json) {
    return TrainingPlanDTO(
      id: json['id'] != null ? json['id'] as int : null,
      name: json['name'] != null ? TranslatedStringDto.fromJson(json['name']) : null,
      description: json['description'] != null ? TranslatedStringDto.fromJson(json['description']) : null,
      days: (json['days'] as List?)
          ?.map((e) => TrainingPlanDayDTO.fromJson(e))
          .whereType<TrainingPlanDayDTO>()
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (name != null) 'name': name!.toJson(),
      if (description != null) 'description': description!.toJson(),
      'days': days.map((e) => e.toJson()).toList(),
    };
  }
}