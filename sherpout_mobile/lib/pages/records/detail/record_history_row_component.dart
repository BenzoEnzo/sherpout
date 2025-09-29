import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sherpoutmobile/pages/records/list/record_list_item_footer.dart';
import '../../../common/dto/record_history_dto.dart';

class RecordHistoryRowComponent extends StatelessWidget {
  const RecordHistoryRowComponent(
      {super.key,
      required this.record,
      this.verticalGap = 0,
      required this.onEdit,
      required this.onDelete});

  final RecordHistoryDTO record;
  final double verticalGap;
  final Future<void> Function(RecordHistoryDTO record) onEdit;
  final Future<void> Function(int id) onDelete;

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('dd.MM.yyyy').format(record.date);

    return Padding(
        padding: EdgeInsets.symmetric(vertical: verticalGap),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RecordListItemFooter(
                      formattedDate: formattedDate,
                      weight: record.value,
                      color: Colors.lightBlueAccent),
                ],
              ),
            ),
            IconButton(
              visualDensity: VisualDensity.compact,
              icon: const Icon(Icons.edit, size: 20),
              onPressed: () => onEdit(record),
            ),
            IconButton(
              visualDensity: VisualDensity.compact,
              icon: const Icon(Icons.close, size: 20),
              onPressed: () => onDelete(record.id!),
            ),
          ],
        ));
  }
}
