import 'package:sherpoutmobile/common/dto/exercise_select_dto.dart';

class RecordDTO {
  final int? id;
  final DateTime date;
  final int value;
  final ExerciseSelectDTO exercise;

  RecordDTO({
    this.id,
    required this.date,
    required this.value,
    required this.exercise,
  });

  factory RecordDTO.fromJson(Map<String, dynamic> json) {
    return RecordDTO(
      id: json['id'] != null ? json['id'] as int : null,
      date: DateTime.parse(json['date'] as String),
      value: json['value'] as int,
      exercise: ExerciseSelectDTO.fromJson(json['exercise']),
    );
  }
}
