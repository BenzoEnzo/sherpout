import 'package:flutter/material.dart';

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
      validator: _validate,
      onSaved: _onSaved,
    );
  }

  String? _validate(String? value) {
    if (isRequired && (value == null || value.isEmpty)) {
      return "This field is required.";
    }
    if (value != null && value.isNotEmpty) {
      final parsed = isDecimal ? double.tryParse(value) : int.tryParse(value);
      if (parsed == null) {
        return "This field has to be number";
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