import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../common/dto/date_range_query_param.dart';
import '../../../common/theme/app_colors.dart';
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
  late DateRangeQueryParam _range;

  @override
  void initState() {
    super.initState();
    _range = widget.initialRange;
  }

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
                tooltip: 'Wybierz zakres',
                onPressed: () async {
                  final earliest = _range.from.isBefore(DateTime(2000))
                      ? _range.from
                      : DateTime(2000);

                  final picked = await showDateRangePicker(
                    context: context,
                    locale: const Locale('pl', 'PL'),
                    firstDate: earliest,
                    lastDate: DateTime.now(),
                    initialDateRange: DateTimeRange(
                      start: _range.from,
                      end: _range.to,
                    ),
                  );
                  if (picked != null) {
                    setState(() {
                      _range = DateRangeQueryParam(
                        from: picked.start,
                        to: picked.end,
                      );
                    });
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