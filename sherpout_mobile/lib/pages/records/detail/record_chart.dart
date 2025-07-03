import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

import '../../../common/chart/generic_line_chart.dart';
import '../../../common/dto/date_range_query_param.dart';
import '../../../common/dto/record_history_dto.dart';
import '../../../services/record_service.dart';
import 'record_content_card.dart';

class RecordChart extends StatelessWidget {
  const RecordChart({
    super.key,
    required this.exerciseId,
    required this.range,
    this.lineColor,
  });

  final int exerciseId;
  final DateRangeQueryParam range;
  final Color? lineColor;

  @override
  Widget build(BuildContext context) {
    final recordService = GetIt.instance<RecordService>();

    return FutureBuilder<List<RecordHistoryDTO>>(
      future: recordService.getRecordHistory(exerciseId, range),
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

        final minYv = data.map((e) => e.value).reduce(math.min).toDouble();
        final maxYv = data.map((e) => e.value).reduce(math.max).toDouble();
        final yStep = _niceStep((maxYv - minYv) / 5);
        final minY  = (minYv / yStep).floor() * yStep;
        final maxY  = (maxYv / yStep).ceil()  * yStep;

        final minX = spots.first.x, maxX = spots.last.x;
        final every = (spots.length / 6).ceil().clamp(1, spots.length);
        final xStep = (maxX - minX) / spots.length * every;

        return RecordContentCard(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: GenericLineChart(
              spots: spots,
              minY : minY,
              maxY : maxY,
              showX: true,
              showY: true,
              xInterval: xStep,
              yInterval: yStep,
              xLabel: (v) => _showX(v, minX, maxX, spots.length, every)
                  ? DateFormat('MM.dd').format(
                  DateTime.fromMillisecondsSinceEpoch(v.toInt()))
                  : '',
              yLabel: (v) => v % yStep == 0 ? '${v.toStringAsFixed(0)} kg' : '',
            ),
          ),
        );
      },
    );
  }

  double _niceStep(double raw) {
    final p = math.pow(10, (math.log(raw) / math.ln10).floor()).toDouble();
    final f = raw / p;
    if (f < 1.5) return 1 * p;
    if (f < 3)   return 2 * p;
    if (f < 7)   return 5 * p;
    return 10 * p;
  }

  bool _showX(double v, double minX, double maxX, int total, int every) {
    final idx = ((v - minX) / ((maxX - minX) / total)).round();
    return idx % every == 0;
  }
}