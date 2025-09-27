import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

abstract class AppField<T> extends StatelessWidget {
  final String label;
  final T? initialValue;
  final void Function(T value) setValue;
  final bool isRequired;

  const AppField({super.key,
    required this.label,
    required this.initialValue,
    required this.setValue,
    required this.isRequired,
  });

  String? validate(String? value, BuildContext context) {
    if (isRequired && (value?.isEmpty ?? true)) {
      return AppLocalizations.of(context)!.thisFieldIsRequired;
    }
    return null;
  }

}