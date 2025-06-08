import 'package:flutter/cupertino.dart';
import 'package:sherpoutmobile/common/components/app_dialog.dart';
import 'package:sherpoutmobile/common/dto/record_dto.dart';
import 'package:sherpoutmobile/pages/records/form/record_form.dart';

class RecordCreateDialog extends StatelessWidget {
  const RecordCreateDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AppDialog(
        title: "Dodaj nowy rekord", child: RecordForm(record: RecordDTO()));
  }
}
