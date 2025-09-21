import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppNumberField extends StatelessWidget {
  final String label;
  final num? initialValue;
  final void Function(num value) setValue;
  final bool isRequired;
  final bool isDecimal;

  const AppNumberField({super.key,
    required this.label,
    required this.initialValue,
    required this.setValue,
    required this.isRequired,
    this.isDecimal = false
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue?.toString() ?? '',
      decoration: InputDecoration(label: Text(label)),
      keyboardType: TextInputType.numberWithOptions(
        decimal: isDecimal,
        signed: false,
      ),
      validator: (value) => _validate(value, context),
      onSaved: (value) => _onSaved(value)
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

  String? validateRequired(String? value, BuildContext context) {
    if (isRequired && (value?.isEmpty ?? true)) {
      return AppLocalizations.of(context)!.thisFieldIsRequired;
    }
    return null;
  }

  void _onSaved(String? value) {
    if (value != null && value.isNotEmpty) {
      final parsed = isDecimal ? double.tryParse(value) : int.tryParse(value);
      if (parsed != null) {
        setValue(parsed);
      }
    }
  }
}