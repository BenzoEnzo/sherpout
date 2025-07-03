import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

import '../components/date_range_picker_dialog.dart';
import '../dto/date_range_query_param.dart';

class GenericLineChart extends StatefulWidget {
  const GenericLineChart({
    super.key,
    required this.data,
    this.initialRange,
    this.lineColor = Colors.lightBlueAccent,
    this.showDots = true,
    this.curved = false,
  });

  final List<FlSpot> data;
  final DateRangeQueryParam? initialRange;
  final Color lineColor;
  final bool showDots;
  final bool curved;

  @override
  State<GenericLineChart> createState() => _GenericLineChartState();
}

class _GenericLineChartState extends State<GenericLineChart> {
  late DateRangeQueryParam _range = widget.initialRange ??
      DateRangeQueryParam(
        from: DateTime.fromMillisecondsSinceEpoch(widget.data.first.x.toInt()),
        to: DateTime.fromMillisecondsSinceEpoch(widget.data.last.x.toInt()),
      );

  List<FlSpot> get _spots => widget.data
      .where((s) =>
  s.x >= _range.from.millisecondsSinceEpoch &&
      s.x <= _range.to.millisecondsSinceEpoch)
      .toList();

  // ---------- Y -------------------------------------------------------------

  double get _minY => _spots.map((e) => e.y).reduce(math.min);
  double get _maxY => _spots.map((e) => e.y).reduce(math.max);

  double get _yStep {
    final span = _maxY - _minY;
    if (span == 0) return 1;                 // tylko jedna wartość
    return _niceStep(span / 5);
  }

  double _niceStep(double raw) {
    if (raw <= 0) return 1;                  // zabezpieczenie
    final p = math.pow(10, (math.log(raw) / math.ln10).floor()).toDouble();
    final f = raw / p;
    if (f < 1.5) return 1 * p;
    if (f < 3)   return 2 * p;
    if (f < 7)   return 5 * p;
    return 10 * p;
  }

  double get _chartMinY =>
      (_minY == _maxY) ? _minY - 1 : (_minY / _yStep).floor() * _yStep;
  double get _chartMaxY =>
      (_minY == _maxY) ? _maxY + 1 : (_maxY / _yStep).ceil() * _yStep;

  // ---------- X -------------------------------------------------------------

  double get _minX => _spots.first.x;
  double get _maxX => _spots.last.x;

  double get _xStep {
    final span = _maxX - _minX;
    if (span == 0) return 1;                 // tylko jeden punkt
    final every = (_spots.length / 6).ceil().clamp(1, _spots.length);
    return span / _spots.length * every;
  }

  bool _showX(double v) {
    final span = _maxX - _minX;
    if (span == 0) return true;              // zawsze pokaż etykietę dla jednego punktu
    final idx = ((v - _minX) / (span / _spots.length)).round();
    final every = (_spots.length / 6).ceil().clamp(1, _spots.length);
    return idx % every == 0;
  }

  // ---------- UI ------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    if (_spots.isEmpty) {
      return const Center(child: Text('Brak danych w wybranym zakresie'));
    }

    return Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${DateFormat('dd.MM.yyyy').format(_range.from)} – '
                    '${DateFormat('dd.MM.yyyy').format(_range.to)}',
                style: Theme.of(context)
                    .textTheme
                    .labelMedium
                    ?.copyWith(color: Colors.grey),
              ),
              IconButton(
                icon: const Icon(Icons.filter_alt_outlined),
                onPressed: _pickRange,
              ),
            ],
          ),
        ),
        Expanded(
          child: LineChart(
            LineChartData(
              minY: _chartMinY,
              maxY: _chartMaxY,
              titlesData: FlTitlesData(
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: _xStep,
                    getTitlesWidget: (v, _) => Text(
                      _showX(v)
                          ? DateFormat('MM.dd').format(
                          DateTime.fromMillisecondsSinceEpoch(v.toInt()))
                          : '',
                      style: const TextStyle(fontSize: 10),
                    ),
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: _yStep,
                    reservedSize: 40,
                    getTitlesWidget: (v, _) => Text(
                      v % _yStep == 0 ? '${v.toStringAsFixed(0)} kg' : '',
                      style: const TextStyle(fontSize: 10),
                    ),
                  ),
                ),
                rightTitles: const AxisTitles(),
                topTitles: const AxisTitles(),
              ),
              gridData: FlGridData(
                horizontalInterval: _yStep,
                drawVerticalLine: false,
                getDrawingHorizontalLine: (_) =>
                    FlLine(color: Colors.transparent, strokeWidth: 1),
              ),
              lineBarsData: [
                LineChartBarData(
                  spots: _spots,
                  isCurved: widget.curved,
                  barWidth: 3,
                  dotData: FlDotData(show: widget.showDots),
                  color: widget.lineColor,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _pickRange() async {
    final picked = await showDialog<DateRangeQueryParam>(
      context: context,
      builder: (_) => AppDateRangePickerDialog(initial: _range),
    );
    if (picked != null) {
      setState(() => _range = picked);
    }
  }
}
