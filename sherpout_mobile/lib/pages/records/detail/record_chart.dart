import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../common/components/loading_component.dart';
import '../../../common/chart/generic_line_chart.dart';
import '../../../common/dto/date_range_query_param.dart';
import '../../../common/dto/record_history_dto.dart';
import '../../../services/record_service.dart';
import 'record_content_card.dart';

class RecordChart extends StatefulWidget {
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
  State<RecordChart> createState() => _RecordChartState();
}

class _RecordChartState extends State<RecordChart> {
  final RecordService _recordService = GetIt.instance<RecordService>();

  bool _isLoading = true;
  String? _error;
  List<RecordHistoryDTO> _data = [];

  DateRangeQueryParam get _queryRange => widget.initialRange ??
      DateRangeQueryParam(from: DateTime(1900), to: DateTime.now());

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      final fetched = await _recordService.getRecordHistory(
        widget.exerciseId,
        _queryRange,
      );
      fetched.sort((a, b) => a.date.compareTo(b.date));
      setState(() {
        _data = fetched;
      });
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LoadingComponent(
      isLoading: _isLoading,
      error: _error,
      child: _data.isEmpty
          ? const Center(child: Text('Brak danych'))
          : RecordContentCard(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: GenericLineChart(
            data: _toSpots(_data),
            initialRange: widget.initialRange,
          ),
        ),
      ),
    );
  }

  List<FlSpot> _toSpots(List<RecordHistoryDTO> list) {
    return [
      for (final r in list)
        FlSpot(
          r.date.millisecondsSinceEpoch.toDouble(),
          r.value.toDouble(),
        )
    ];
  }
}
