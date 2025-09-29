import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../common/components/loading_component.dart';
import '../../../common/dto/date_range_query_param.dart';
import '../../../common/dto/record_dto.dart';
import '../../../common/dto/record_history_dto.dart';
import '../../../services/record_service.dart';
import '../delete/record_delete_dialog.dart';
import '../form/record_form.dart';
import 'record_history_row_component.dart';
import 'record_content_card.dart';
import 'record_history_year_divider.dart';

class RecordHistory extends StatefulWidget {
  const RecordHistory({
    super.key,
    required this.exerciseId,
    required this.range,
  });

  final int exerciseId;
  final DateRangeQueryParam range;

  @override
  State<RecordHistory> createState() => _RecordHistoryState();
}

class _RecordHistoryState extends State<RecordHistory> {
  final RecordService _recordService = GetIt.instance<RecordService>();

  bool _isLoading = true;
  String? _error;
  List<RecordHistoryDTO> _records = [];

  @override
  void initState() {
    super.initState();
    _loadRecords();
  }

  Future<void> _loadRecords() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      final data = await _recordService.getRecordHistory(
        widget.exerciseId,
        widget.range,
      );
      data.sort((a, b) => b.date.compareTo(a.date));
      setState(() {
        _records = data;
      });
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _refresh() => _loadRecords();

  @override
  Widget build(BuildContext context) {
    return LoadingComponent(
      isLoading: _isLoading,
      error: _error,
      child: _records.isEmpty
          ? const Center(child: Text('Brak rekordów w tym okresie'))
          : RecordContentCard(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: _buildList(),
        ),
      ),
    );
  }

  List<Widget> _buildList() {
    final Map<int, List<RecordHistoryDTO>> byYear = {};
    for (final record in _records) {
      byYear.putIfAbsent(record.date.year, () => []).add(record);
    }
    final years = byYear.keys.toList()..sort((b, a) => a.compareTo(b));

    final widgets = <Widget>[];
    for (final year in years) {
      widgets.add(RecordHistoryYearDivider(year: year));
      for (final rec in byYear[year]!) {
        widgets.add(
          RecordHistoryRowComponent(
            record: rec,
            verticalGap: 8,
            onEdit: () async {
              final edited = await showDialog<bool>(
                context: context,
                builder: (_) => Dialog(
                  insetPadding: const EdgeInsets.all(24),
                  child: RecordForm(
                    record: RecordDTO(
                      id: rec.id,
                      date: rec.date,
                      value: rec.value,
                    ),
                    isEdit: true,
                  ),
                ),
              );
              if (edited == true) _refresh();
            },
            onDelete: () async {
              final deleted = await showDialog<bool>(
                context: context,
                builder: (_) => RecordDeleteDialog(id: rec.id!),
              );
              if (deleted == true) _refresh();
            },
          ),
        );
      }
    }
    return widgets;
  }
}
