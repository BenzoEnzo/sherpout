import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../../common/chart/generic_line_chart.dart';
import '../../../common/dto/date_range_query_param.dart';
import '../../../common/dto/record_history_dto.dart';
import '../../../services/record_service.dart';
import 'record_content_card.dart';

class RecordChart extends StatelessWidget {
  const RecordChart({
    super.key,
    required this.exerciseId,
    this.initialRange,
    this.lineColor,
  });

  final int exerciseId;
  final DateRangeQueryParam? initialRange;
  final Color? lineColor;

  @override
  Widget build(BuildContext context) {
    final queryRange = initialRange ??
        DateRangeQueryParam(
          from: DateTime(1900),
          to: DateTime.now(),
        );

    final recordService = GetIt.instance<RecordService>();

    return FutureBuilder<List<RecordHistoryDTO>>(
      future: recordService.getRecordHistory(exerciseId, queryRange),
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snap.hasError) {
          return Center(child: Text('Error: ${snap.error}'));
        }

        final data = snap.data!..sort((a, b) => a.date.compareTo(b.date));
        if (data.isEmpty) return const Center(child: Text('Brak danych'));

        final spots = [
          for (final r in data)
            FlSpot(r.date.millisecondsSinceEpoch.toDouble(), r.value.toDouble())
        ];

        return RecordContentCard(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: GenericLineChart(
              data: spots,
              initialRange: initialRange,
            ),
          ),
        );
      },
    );
  }
}
