import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sherpoutmobile/common/dto/record_dto.dart';
import 'package:sherpoutmobile/pages/records/list/record_list_item_footer.dart';
import 'package:sherpoutmobile/pages/records/list/record_list_item_header.dart';
import '../../../common/theme/app_colors.dart';
import '../../exercises/list/exercise_cover.dart';

class RecordItem extends StatelessWidget {
  final RecordDTO record;

  const RecordItem({
    super.key,
    required this.record,
  });

  @override
  Widget build(BuildContext context) {
    final exerciseName = record.exercise.name.localized(context);
    final formattedDate = DateFormat('dd.MM.yyyy').format(record.date);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.secondary, width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ExerciseCover(cover: record.exercise.cover),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RecordListItemHeader(exerciseName: exerciseName),
                const SizedBox(height: 8),
                RecordListItemFooter(formattedDate: formattedDate, weight: record.value),
              ],
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.chevron_right),
        ],
      ),
    );
  }
}




