import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../common/dto/record_dto.dart';
import '../../../../common/theme/app_colors.dart';
import '../../exercises/list/exercise_cover.dart';
import '../detail/record_detail_page.dart';
import 'record_list_item_footer.dart';
import 'record_list_item_header.dart';

class RecordItem extends StatelessWidget {
  final RecordDTO record;

  const RecordItem({
    super.key,
    required this.record,
  });

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('dd.MM.yyyy').format(record.date!);

    return InkWell(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => RecordDetailPage(record: record),
        ),
      ),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.secondary, width: 1),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ExerciseCover(cover: record.exercise!.cover),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RecordListItemHeader(exerciseName: record.exercise!.name),
                  RecordListItemFooter(
                    formattedDate: formattedDate,
                    weight: record.value!,
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }
}
