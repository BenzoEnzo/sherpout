import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sherpoutmobile/common/components/buttons/app_text_and_icon_button.dart';
import 'package:sherpoutmobile/pages/records/create/record_create_dialog.dart';

class NewRecordButton extends StatelessWidget {
  final VoidCallback onPressed;

  const NewRecordButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppTextAndIconButton(
        text: AppLocalizations.of(context)!.addNew,
        icon: Icons.add,
        onPressed: () => showRecordCreateDialog(context));
  }

  void showRecordCreateDialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => RecordCreateDialog());
  }
}
