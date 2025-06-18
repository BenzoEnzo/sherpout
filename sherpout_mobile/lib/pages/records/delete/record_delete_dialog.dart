import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
    return AppDialog(
        title: AppLocalizations.of(context)!.deleteRecord,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(AppLocalizations.of(context)!.deleteRecordConfirmMessage,
                style: AppTypography.bodyLarge),
            SizedBox(height: 16),
            AppTextButton(
                text: AppLocalizations.of(context)!.yes,
                onPressed: () => deleteRecord(id))
          ],
        ));
  }

  void deleteRecord(int id) {
    _recordService.delete(id);
  }
}
