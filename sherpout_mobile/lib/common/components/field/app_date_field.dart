import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sherpoutmobile/common/components/field/app_field.dart';

class AppDateField extends AppField<DateTime> {
  final DateTime firstDate;
  final DateTime lastDate;
  final DateFormat dateFormat;

  AppDateField({super.key,
    required super.label,
    required super.initialValue,
    required super.setValue,
    required super.isRequired,
    DateTime? firstDate,
    DateTime? lastDate,
    DateFormat? dateFormat,
  })  : dateFormat = dateFormat ?? DateFormat('yyyy-MM-dd'),
        lastDate = lastDate ?? DateTime(2100),
        firstDate = firstDate ?? DateTime(2010);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue != null ? dateFormat.format(initialValue!) : '',
      decoration: InputDecoration(
        label: Text(label),
        suffixIcon: const Icon(Icons.calendar_today),
      ),
      readOnly: true,
      validator: (value) => validate(value, context),
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: initialValue ?? DateTime.now(),
          firstDate: firstDate,
          lastDate: lastDate,
        );

        if (picked != null) {
          setValue(picked);
        }
      },
    );
  }
}