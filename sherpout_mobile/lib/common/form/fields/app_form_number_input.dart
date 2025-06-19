import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'app_form_field.dart';

class AppFormNumberInput<T> extends AppFormField<T, num> {
  final bool isDecimal;

  AppFormNumberInput({
    required String label,
    required num? Function(T dto) getValue,
    required void Function(T dto, num value) setValue,
    required bool isRequired,
    this.isDecimal = false
  }) : super(label, getValue, setValue, isRequired);

  @override
  Widget build(BuildContext context, T dto) {
    final initialValue = getValue(dto)?.toString() ?? '';

    return TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(
        labelText: label,
        suffix: Text("kg"),
      ),
      keyboardType: TextInputType.numberWithOptions(
        decimal: isDecimal,
        signed: false,
      ),
      validator: (value) => _validate(value, context),
      onSaved: (value) => _onSaved(value, dto),
    );
  }

  String? _validate(String? value, BuildContext context) {
    final requiredValidation = validateRequired(value, context);
    if (requiredValidation != null) return requiredValidation;

    if (value != null && value.isNotEmpty) {
      final parsed = isDecimal ? double.tryParse(value) : int.tryParse(value);
      if (parsed == null) {
        return AppLocalizations.of(context)!.thisFieldHasToBeNumber;
      }
    }
    return null;
  }

  void _onSaved(String? value, T dto) {
    if (value != null && value.isNotEmpty) {
      final parsed = isDecimal ? double.tryParse(value) : int.tryParse(value);
      if (parsed != null) {
        setValue(dto, parsed);
      }
    }
  }
}
