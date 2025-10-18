import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'app_form_field.dart';


class AppFormDateInput<T> extends AppFormField<T, DateTime> {
  final DateTime? firstDate;
  final DateTime? lastDate;
  final DateFormat? dateFormat;

  AppFormDateInput({
    required String key,
    required String label,
    required DateTime? Function(T dto) getValue,
    required void Function(T dto, DateTime value) setValue,
    required bool isRequired,
    this.firstDate,
    this.lastDate,
    this.dateFormat,
  }) : super(key, label, getValue, setValue, isRequired);

  @override
  Widget build(BuildContext context, T dto, List<String>? errors) {
    final DateTime effectiveFirstDate = firstDate ?? DateTime(2010);
    final DateTime effectiveLastDate = lastDate ?? DateTime(2100);
    final DateFormat effectiveDateFormat =
        dateFormat ?? DateFormat('yyyy-MM-dd');

    final currentDate = getValue(dto);
    final controller = TextEditingController(
      text: currentDate != null ? effectiveDateFormat.format(currentDate) : '',
    );

    return TextFormField(
      controller: controller,
      decoration: buildInputDecoration(errors)
          .copyWith(suffixIcon: const Icon(Icons.calendar_today)),
      readOnly: true,
      validator: (value) => validateRequired(value, context),
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: currentDate ?? DateTime.now(),
          firstDate: effectiveFirstDate,
          lastDate: effectiveLastDate,
        );

        if (picked != null) {
          setValue(dto, picked);
          controller.text = effectiveDateFormat.format(picked);
        }
      },
    );
  }
}
