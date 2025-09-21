import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppDateField extends StatelessWidget {
  final String label;
  final DateTime? initialValue;
  final void Function(DateTime value) setValue;
  final bool isRequired;

  final DateTime? firstDate;
  final DateTime? lastDate;
  final DateFormat? dateFormat;

  const AppDateField({super.key,
    required this.label,
    required this.initialValue,
    required this.setValue,
    required this.isRequired,
    this.firstDate,
    this.lastDate,
    this.dateFormat,
  });

  @override
  Widget build(BuildContext context) {
    final DateTime effectiveFirstDate = firstDate ?? DateTime(2010);
    final DateTime effectiveLastDate = lastDate ?? DateTime(2100);
    final DateFormat effectiveDateFormat =
        dateFormat ?? DateFormat('yyyy-MM-dd');

    final controller = TextEditingController(
      text: initialValue != null ? effectiveDateFormat.format(initialValue!) : '',
    );

    return TextFormField(
      controller: controller,
      decoration: InputDecoration(label: Text(label), suffixIcon: const Icon(Icons.calendar_today)),
      readOnly: true,
      validator: (value) => validateRequired(value, context),
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: initialValue ?? DateTime.now(),
          firstDate: effectiveFirstDate,
          lastDate: effectiveLastDate,
        );

        if (picked != null) {
          setValue(picked);
          controller.text = effectiveDateFormat.format(picked);
        }
      },
    );
  }

  String? validateRequired(String? value, BuildContext context) {
    if (isRequired && (value?.isEmpty ?? true)) {
      return AppLocalizations.of(context)!.thisFieldIsRequired;
    }
    return null;
  }
}