import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sherpoutmobile/common/components/app_page.dart';
import 'package:sherpoutmobile/common/dto/record_dto.dart';
import 'package:sherpoutmobile/pages/records/form/record_form.dart';

class RecordCreatePage extends StatelessWidget {
  const RecordCreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.addNew),
        ),
        body: AppPage(
          child: Center(
            child: RecordForm(record: RecordDTO()),
          ),
        ));
  }
}