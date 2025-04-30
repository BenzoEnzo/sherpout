
class RecordHistoryDTO {
  final int? id;
  final DateTime date;
  final int value;

  RecordHistoryDTO({
    this.id,
    required this.date,
    required this.value,
  });

  factory RecordHistoryDTO.fromJson(Map<String, dynamic> json) {
    return RecordHistoryDTO(
      id: json['id'] != null ? json['id'] as int : null,
      date: DateTime.parse(json['date'] as String),
      value: json['value'] as int,
    );
  }
}
