import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppFormNumberInput<T> extends StatelessWidget {
  final T dto;
  final String label;
  final bool isRequired;
  final num? Function(T dto) getValue;
  final void Function(T dto, num value) setValue;
  final bool isDecimal;

  const AppFormNumberInput({
    super.key,
    required this.dto,
    required this.label,
    required this.isRequired,
    required this.getValue,
    required this.setValue,
    this.isDecimal = false,
  });

  @override
  Widget build(BuildContext context) {
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
      onSaved: _onSaved,
    );
  }

  String? _validate(String? value, BuildContext context) {
    if (isRequired && (value == null || value.isEmpty)) {
      return AppLocalizations.of(context)!.thisFieldIsRequired;
    }
    if (value != null && value.isNotEmpty) {
      final parsed = isDecimal ? double.tryParse(value) : int.tryParse(value);
      if (parsed == null) {
        return AppLocalizations.of(context)!.thisFieldHasToBeNumber;
      }
    }
    return null;
  }

  void _onSaved(String? value) {
    if (value != null && value.isNotEmpty) {
      final parsed = isDecimal ? double.tryParse(value) : int.tryParse(value);
      if (parsed != null) {
        setValue(dto, parsed);
      }
    }
  }
}