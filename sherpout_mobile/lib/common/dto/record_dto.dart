import 'package:sherpoutmobile/common/dto/exercise_select_dto.dart';

class RecordDTO {
  final int? id;
  DateTime? date;
  num? value;
  ExerciseSelectDTO? exercise;

  RecordDTO({
    this.id,
    this.date,
    this.value,
    this.exercise,
  });

  factory RecordDTO.fromJson(Map<String, dynamic> json) {
    return RecordDTO(
      id: json['id'] != null ? json['id'] as int : null,
      date: DateTime.parse(json['date'] as String),
      value: json['value'] as num,
      exercise: ExerciseSelectDTO.fromJson(json['exercise']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (date != null) 'date': date!.toIso8601String(),
      if (value != null) 'value': value,
      if (exercise != null) 'exercise': exercise!.toJson(),
    };
  }
}
