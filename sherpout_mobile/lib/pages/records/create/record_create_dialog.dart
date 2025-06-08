import 'package:flutter/cupertino.dart';
import 'package:sherpoutmobile/common/components/app_dialog.dart';
import 'package:sherpoutmobile/common/dto/record_dto.dart';
import 'package:sherpoutmobile/pages/records/form/record_form.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RecordCreateDialog extends StatelessWidget {
  const RecordCreateDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AppDialog(
        title: AppLocalizations.of(context)!.addNewRecord, child: RecordForm(record: RecordDTO()));
  }
}
