import 'package:intl/intl.dart';

final _dateOnly = DateFormat('yyyy-MM-dd');

class DateRangeQueryParam {
  final DateTime from;
  final DateTime to;

  DateRangeQueryParam({
    required this.from,
    required this.to,
  }) : assert(!from.isAfter(to), '`from` > `to`');

  Map<String, String> asQueryParameters() => {
        'from': _dateOnly.format(from),
        'to': _dateOnly.format(to),
      };

  static DateRangeQueryParam all() => DateRangeQueryParam(
    from: DateTime.fromMillisecondsSinceEpoch(0),
    to: DateTime.now(),
  );

  Map<String, dynamic> toJson() => asQueryParameters();
}
