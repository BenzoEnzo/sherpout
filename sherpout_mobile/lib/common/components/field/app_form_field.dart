import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

abstract class AppFormField<T, V> {
  final String key;
  final String label;
  final V? Function(T dto) getValue;
  final void Function(T dto, V value) setValue;
  final bool isRequired;

  AppFormField(this.key, this.label, this.getValue, this.setValue, this.isRequired);

  Widget build(BuildContext context, T dto, List<String>? errors);

  InputDecoration buildInputDecoration(List<String>? errors) {
    return InputDecoration(
        label: Text(label),
        error: _buildErrors(errors)
    );
  }

  Widget? _buildErrors(List<String>? errors) {
    if (errors == null) {
      return null;
    }

    return Column(children: [
      ...errors.map((e) => Text(e))
    ]);
  }

  String? validateRequired(String? value, BuildContext context) {
    if (isRequired && (value?.isEmpty ?? true)) {
      return AppLocalizations.of(context)!.thisFieldIsRequired;
    }
    return null;
  }
}
