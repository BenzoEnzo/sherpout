import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:sherpoutmobile/pages/records/detail/record_history_row_component.dart';

import '../../../common/dto/date_range_query_param.dart';
import '../../../common/dto/record_dto.dart';
import '../../../common/dto/record_history_dto.dart';
import '../../../services/record_service.dart';
import '../list/record_row_component.dart';

class RecordHistory extends StatelessWidget {
  RecordHistory({
    super.key,
    required this.exerciseId,
    required this.range,
  }) : _recordService = GetIt.instance<RecordService>();

  final int exerciseId;
  final DateRangeQueryParam range;
  final RecordService _recordService;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<RecordHistoryDTO>>(
      future: _recordService.getRecordHistory(exerciseId, range),
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snap.hasError) {
          return Center(child: Text('Error: ${snap.error}'));
        }

        final records = snap.data!..sort((a, b) => b.date.compareTo(a.date));
        if (records.isEmpty) {
          return const Center(child: Text('Brak rekordów w tym okresie'));
        }

        final Map<int, List<RecordHistoryDTO>> byYear = {};
        for (final record in records) {
          byYear.putIfAbsent(record.date.year, () => []).add(record);
        }
        final years = byYear.keys.toList()..sort((b, a) => a.compareTo(b));

        final list = <Widget>[];
        for (final year in years) {
          list.add(Padding(
            padding: const EdgeInsets.only(top: 16, bottom: 8),
            child: Row(
              children: [
                Text(
                  year.toString(),
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(color: Colors.blueGrey.shade300),
                ),
                const SizedBox(width: 12),
                const Expanded(child: Divider(thickness: 1)),
              ],
            ),
          ));

          for (final record in byYear[year]!) {
            list.add(RecordHistoryRowComponent(record: record, verticalGap: 8));
          }
        }

        return ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: list,
        );
      },
    );
  }
}
