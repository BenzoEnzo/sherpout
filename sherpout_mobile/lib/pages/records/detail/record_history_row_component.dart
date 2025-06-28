import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sherpoutmobile/common/dto/record_dto.dart';
import 'package:sherpoutmobile/pages/records/list/record_list_item_footer.dart';
import 'package:sherpoutmobile/pages/records/list/record_list_item_header.dart';
import '../../../common/dto/record_history_dto.dart';
import '../../../common/theme/app_colors.dart';
import '../../exercises/list/exercise_cover.dart';

class RecordHistoryRowComponent extends StatelessWidget {
  const RecordHistoryRowComponent({
    super.key,
    required this.record,
    this.showChevron = true,
    this.padding = const EdgeInsets.all(12),
  });

  final RecordHistoryDTO record;
  final bool showChevron;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('dd.MM.yyyy').format(record.date!);

    return Container(
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.secondary, width: 1),
      ),
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
                  weight: record.value!,
                ),
              ],
            ),
          ),
          if (showChevron) const Icon(Icons.chevron_right),
        ],
      ),
    );
  }
}