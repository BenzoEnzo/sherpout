import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components/buttons/app_text_and_icon_button.dart';

class AppFormSaveButton<T> extends StatelessWidget {
  final void Function() onSubmit;
  final bool isLoading;

  const AppFormSaveButton(
      {super.key, required this.onSubmit, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: AppTextAndIconButton(
        onPressed: onSubmit,
        text: 'Save',
        icon: Icons.save_outlined,
        isLoading: isLoading,
      ),
    );
  }
}
