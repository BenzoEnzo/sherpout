import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppFormDateInput<T> extends StatelessWidget {
  final T dto;
  final String label;
  final bool isRequired;
  final DateTime? Function(T dto) getValue;
  final void Function(T dto, DateTime value) setValue;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final DateFormat? dateFormat;

  const AppFormDateInput({
    super.key,
    required this.dto,
    required this.label,
    required this.isRequired,
    required this.getValue,
    required this.setValue,
    this.firstDate,
    this.lastDate,
    this.dateFormat,
  });

  @override
  Widget build(BuildContext context) {
    final DateTime effectiveFirstDate = firstDate ?? DateTime(2010);
    final DateTime effectiveLastDate = lastDate ?? DateTime(2100);
    final DateFormat effectiveDateFormat = dateFormat ?? DateFormat('yyyy-MM-dd');

    final currentDate = getValue(dto);
    final controller = TextEditingController(
      text: currentDate != null ? effectiveDateFormat.format(currentDate) : '',
    );

    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        suffixIcon: const Icon(Icons.calendar_today),
      ),
      readOnly: true,
      validator: _validate,
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

  String? _validate(String? value) {
    if (isRequired && (value == null || value.isEmpty)) {
      return "This field is required.";
    }
    return null;
  }
}