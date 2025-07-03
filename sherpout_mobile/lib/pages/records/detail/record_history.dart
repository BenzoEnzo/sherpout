import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../common/dto/date_range_query_param.dart';
import '../../../common/dto/record_dto.dart';
import '../../../common/dto/record_history_dto.dart';
import '../../../services/record_service.dart';
import '../delete/record_delete_dialog.dart';
import '../form/record_form.dart';
import 'record_history_row_component.dart';
import 'record_content_card.dart';

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

  late Future<List<RecordHistoryDTO>> _recordsFut;

  @override
  void initState() {
    super.initState();
    _recordsFut = _recordService.getRecordHistory(
      widget.exerciseId,
      widget.range,
    );
  }

  void _refresh() {
    setState(() {
      _recordsFut = _recordService.getRecordHistory(
        widget.exerciseId,
        widget.range,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<RecordHistoryDTO>>(
      future: _recordsFut,
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
        for (final r in records) {
          byYear.putIfAbsent(r.date.year, () => []).add(r);
        }
        final years = byYear.keys.toList()..sort((b, a) => a.compareTo(b));

        final list = <Widget>[];
        for (final year in years) {
          list.add(
            Padding(
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
            ),
          );

          for (final rec in byYear[year]!) {
            list.add(
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
                            id: rec.id, date: rec.date, value: rec.value),
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

        return RecordContentCard(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: list,
          ),
        );
      },
    );
  }
}
