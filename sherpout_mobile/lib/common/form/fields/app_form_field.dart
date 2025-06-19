import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

abstract class AppFormField<T, V> {
  final String label;
  final V? Function(T dto) getValue;
  final void Function(T dto, V value) setValue;
  final bool isRequired;

  AppFormField(this.label, this.getValue, this.setValue, this.isRequired);

  Widget build(BuildContext context, T dto);

  String? validateRequired(String? value, BuildContext context) {
    if (isRequired && (value?.isEmpty ?? true)) {
      return AppLocalizations.of(context)!.thisFieldIsRequired;
    }
    return null;
  }
}
