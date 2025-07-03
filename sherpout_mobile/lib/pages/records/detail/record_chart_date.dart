import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../common/dto/date_range_query_param.dart';
import '../../../common/theme/app_colors.dart';
import '../../../common/form/app_form_date_input.dart';
import 'record_chart.dart';

class RecordChartDate extends StatefulWidget {
  const RecordChartDate({
    super.key,
    required this.exerciseId,
    required this.initialRange,
    this.lineColor,
  });

  final int exerciseId;
  final DateRangeQueryParam initialRange;
  final Color? lineColor;

  @override
  State<RecordChartDate> createState() => _RecordChartDateState();
}

class _RecordChartDateState extends State<RecordChartDate> {
  late DateRangeQueryParam _range = widget.initialRange;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 8, bottom: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                '${DateFormat('dd.MM.yyyy').format(_range.from)} – '
                    '${DateFormat('dd.MM.yyyy').format(_range.to)}',
                style: Theme.of(context)
                    .textTheme
                    .labelMedium
                    ?.copyWith(color: AppColors.secondary),
              ),
              IconButton(
                icon: const Icon(Icons.filter_alt_outlined),
                onPressed: () async {
                  final picked = await showDialog<DateRangeQueryParam>(
                    context: context,
                    builder: (_) => _RangePickerDialog(initial: _range),
                  );
                  if (picked != null) {
                    setState(() => _range = picked);
                  }
                },
              ),
            ],
          ),
        ),
        Expanded(
          child: RecordChart(
            exerciseId: widget.exerciseId,
            range: _range,
            lineColor: widget.lineColor,
          ),
        ),
      ],
    );
  }
}

class _RangePickerDialog extends StatefulWidget {
  const _RangePickerDialog({required this.initial});
  final DateRangeQueryParam initial;

  @override
  State<_RangePickerDialog> createState() => _RangePickerDialogState();
}

class _RangePickerDialogState extends State<_RangePickerDialog> {
  late DateTime _from = widget.initial.from;
  late DateTime _to   = widget.initial.to;

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
                child: AppFormDateInput<_RangePickerDialogState>(
                  dto: this,
                  label: 'Od',
                  isRequired: true,
                  firstDate: DateTime(1900),
                  lastDate : DateTime.now(),
                  getValue: (_) => _from,
                  setValue: (_, v) => setState(() => _from = v),
                  dateFormat: DateFormat('yyyy-MM-dd'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: AppFormDateInput<_RangePickerDialogState>(
                  dto: this,
                  label: 'Do',
                  isRequired: true,
                  firstDate: DateTime(1900),
                  lastDate : DateTime.now(),
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