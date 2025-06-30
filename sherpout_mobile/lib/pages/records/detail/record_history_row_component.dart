import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sherpoutmobile/common/dto/record_dto.dart';
import 'package:sherpoutmobile/pages/records/list/record_list_item_footer.dart';
import 'package:sherpoutmobile/pages/records/list/record_list_item_header.dart';
import '../../../common/dto/record_history_dto.dart';
import '../../../common/theme/app_colors.dart';
import '../../exercises/list/exercise_cover.dart';

class RecordHistoryRowComponent extends StatelessWidget {
  const RecordHistoryRowComponent(
      {super.key,
      required this.record,
      this.verticalGap = 0,
      this.onEdit,
      this.onDelete});

  final RecordHistoryDTO record;
  final double verticalGap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

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
                    color: Colors.lightBlueAccent
                  ),
                ],
              ),
            ),
            IconButton(
              visualDensity: VisualDensity.compact,
              icon: const Icon(Icons.edit, size: 20),
              onPressed: onEdit,
            ),
            IconButton(
              visualDensity: VisualDensity.compact,
              icon: const Icon(Icons.close, size: 20),
              onPressed: onDelete,
            ),
          ],
        ));
  }
}
