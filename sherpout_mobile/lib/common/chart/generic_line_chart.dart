import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class GenericLineChart extends StatelessWidget {
  const GenericLineChart({
    super.key,
    required this.spots,
    this.minY,
    this.maxY,
    this.showDots = true,
    this.curved = true,
    this.showX = false,
    this.showY = false,
    this.xInterval,
    this.yInterval,
    this.xLabel,
    this.yLabel,
  });

  final List<FlSpot> spots;
  final double? minY;
  final double? maxY;
  final bool showDots;
  final bool curved;

  final bool showX;
  final bool showY;
  final double? xInterval;
  final double? yInterval;
  final String Function(double)? xLabel;
  final String Function(double)? yLabel;

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        minY: minY,
        maxY: maxY,
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: showX,
              interval: xInterval,
              getTitlesWidget: (value, _) => Text(
                xLabel != null ? xLabel!(value) : value.toStringAsFixed(0),
                style: const TextStyle(fontSize: 10),
              ),
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: showY,
              interval: yInterval,
              reservedSize: 40,
              getTitlesWidget: (value, _) => Text(
                yLabel != null ? yLabel!(value) : value.toStringAsFixed(0),
                style: const TextStyle(fontSize: 10),
              ),
            ),
          ),
          rightTitles: const AxisTitles(),
          topTitles: const AxisTitles(),
        ),
        gridData: FlGridData(
          horizontalInterval: yInterval ?? 10,
          drawVerticalLine: false,
          getDrawingHorizontalLine: (_) =>
              FlLine(color: Colors.transparent, strokeWidth: 1),
        ),
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: curved,
            barWidth: 3,
            dotData: FlDotData(show: showDots),
            color: Colors.lightBlueAccent
          ),
        ],
      ),
    );
  }
}