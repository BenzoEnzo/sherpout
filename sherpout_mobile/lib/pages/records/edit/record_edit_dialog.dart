import 'package:flutter/material.dart';
import 'package:sherpoutmobile/common/dto/record_dto.dart';
import 'package:sherpoutmobile/pages/records/form/record_form.dart';

import '../../../common/components/app_dialog.dart';

class RecordEditDialog extends StatelessWidget {
  final RecordDTO record;

  const RecordEditDialog({super.key, required this.record});

  @override
  Widget build(BuildContext context) {
    return AppDialog(title: "Edytuj rekord", child: RecordForm(record: record, isEdit: true));
  }
}
