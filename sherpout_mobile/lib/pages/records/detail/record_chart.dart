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
  RecordChart({
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

        final records = snap.data!..sort((a, b) => a.date.compareTo(b.date));
        if (records.isEmpty) {
          return const Center(child: Text('Brak danych do wykresu'));
        }

        final spots = <FlSpot>[
          for (var record in records)
            FlSpot(record.date.millisecondsSinceEpoch.toDouble(), record.value.toDouble())
        ];

        final minYVal = records.map((e) => e.value).reduce(math.min);
        final maxYVal = records.map((e) => e.value).reduce(math.max);
        final yInterval = 1000.0;
        final minY = (minYVal / yInterval).floor() * yInterval;

        final minX = spots.first.x;
        final maxX = spots.last.x;
        final totalPoints = spots.length;
        final showEvery = (totalPoints / 5).ceil();
        final xInterval = (maxX - minX) / totalPoints * 3;

        return RecordContentCard(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: GenericLineChart(
              spots: spots,
              minY: minY,
              showX: true,
              showY: true,
              xInterval: xInterval,
              yInterval: yInterval,
              xLabel: (v) {
                final idx = ((v - minX) / ((maxX - minX) / totalPoints)).round();
                if (idx % showEvery != 0) return '';
                final dt = DateTime.fromMillisecondsSinceEpoch(v.toInt());
                return DateFormat('MM.dd').format(dt);
              },
              yLabel: (v) =>
              v % yInterval == 0 ? '${v.toStringAsFixed(0)} kg' : '',
            ),
          ),
        );
      },
    );
  }
}