import 'package:flutter/material.dart';

class RecordHistoryYearDivider extends StatelessWidget {
  final int year;

  const RecordHistoryYearDivider({
    super.key,
    required this.year,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      child: Row(
        children: [
          Text(
            year.toString(),
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(color: Colors.blueGrey.shade300),
          ),
          const SizedBox(width: 12),
          const Expanded(child: Divider(thickness: 1)),
        ],
      ),
    );
  }
}