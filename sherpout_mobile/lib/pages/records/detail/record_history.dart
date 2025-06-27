import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../common/dto/date_range_query_param.dart';
import '../../../common/dto/record_dto.dart';
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
    return FutureBuilder<List<RecordDTO>>(
      future: _recordService.getRecordHistory(exerciseId, range),
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snap.hasError) {
          return Center(child: Text('Błąd: ${snap.error}'));
        }

        final records = snap.data!
          ..sort((a, b) => b.date!.compareTo(a.date!));

        if (records.isEmpty) {
          return const Center(child: Text('Brak rekordów w tym okresie'));
        }

        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: records.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (_, i) => RecordRowComponent(
            record: records[i],
            showChevron: false,
            padding: const EdgeInsets.all(16),
          ),
        );
      },
    );
  }
}