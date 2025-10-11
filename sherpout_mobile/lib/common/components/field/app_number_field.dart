import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sherpoutmobile/common/components/field/app_field_stateless_widget.dart';

class AppNumberField extends AppFieldStatelessWidget<num> {
  final bool isDecimal;
  final num min;
  final num max;

  const AppNumberField({super.key,
    required super.label,
    required super.initialValue,
    required super.setValue,
    required super.isRequired,
    this.isDecimal = false,
    required this.min,
    required this.max,
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
      validator: (value) => validate(value, context),
      onChanged: (value) => _onChanged(value)
    );
  }

  @override
  String? validate(String? value, BuildContext context) {
    final requiredValidation = super.validate(value, context);
    if (requiredValidation != null) return requiredValidation;

    if (value != null && value.isNotEmpty) {
      final parsed = _parse(value);
      if (parsed == null) {
        return AppLocalizations.of(context)!.thisFieldHasToBeNumber;
      }

      if (parsed < min) {
        return AppLocalizations.of(context)!.thisFieldHasToBeBiggerThan(min);
      }
      if (parsed > max) {
        return AppLocalizations.of(context)!.thisFieldHasToBeSmallerThan(max);
      }
    }
    return null;
  }

  void _onChanged(String? value) {
    if (value != null && value.isNotEmpty) {
      final parsed = _parse(value);
      if (parsed != null) {
        setValue(parsed);
      }
    }
  }

  num? _parse(String value) {
    return isDecimal ? double.tryParse(value) : int.tryParse(value);
  }
}