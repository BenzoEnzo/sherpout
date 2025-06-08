import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:sherpoutmobile/common/components/buttons/app_text_and_icon_button.dart';

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
        onPressed: () => context.push('/records/create'));
  }
}
