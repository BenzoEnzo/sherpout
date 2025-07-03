import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../dto/date_range_query_param.dart';
import '../form/app_form_date_input.dart';

class AppDateRangePickerDialog extends StatefulWidget {
  const AppDateRangePickerDialog({super.key, required this.initial});
  final DateRangeQueryParam initial;

  @override
  State<AppDateRangePickerDialog> createState() =>
      _AppDateRangePickerDialogState();
}

class _AppDateRangePickerDialogState extends State<AppDateRangePickerDialog> {
  late DateTime _from = widget.initial.from;
  late DateTime _to = widget.initial.to;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Zakres dat'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: AppFormDateInput<_AppDateRangePickerDialogState>(
                  dto: this,
                  label: 'Od',
                  isRequired: true,
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                  getValue: (_) => _from,
                  setValue: (_, v) => setState(() => _from = v),
                  dateFormat: DateFormat('yyyy-MM-dd'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: AppFormDateInput<_AppDateRangePickerDialogState>(
                  dto: this,
                  label: 'Do',
                  isRequired: true,
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                  getValue: (_) => _to,
                  setValue: (_, v) => setState(() => _to = v),
                  dateFormat: DateFormat('yyyy-MM-dd'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(
                context,
                DateRangeQueryParam(from: _from, to: _to),
              ),
              child: const Text('Zastosuj'),
            ),
          ),
        ],
      ),
    );
  }
}