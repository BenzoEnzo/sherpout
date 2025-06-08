import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:sherpoutmobile/common/components/app_dialog.dart';
import 'package:sherpoutmobile/common/components/buttons/app_text_button.dart';
import 'package:sherpoutmobile/common/theme/app_typography.dart';

import '../../../services/record_service.dart';

class RecordDeleteDialog extends StatelessWidget {
  final RecordService _recordService = GetIt.instance<RecordService>();

  final int id;

  RecordDeleteDialog({super.key, required this.id});

  @override
  Widget build(BuildContext context) {

    return AppDialog(title: "Delete record", child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
      Text("Are you sure you want to delete this record?", style: AppTypography.bodyLarge),
      SizedBox(height: 16),
      AppTextButton(text: "Yes", onPressed: () => deleteRecord(id))
    ],));
  }

  void deleteRecord(int id) {
    _recordService.delete(id);
  }
}