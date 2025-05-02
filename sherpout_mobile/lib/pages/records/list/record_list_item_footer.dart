import 'package:flutter/material.dart';

class RecordListItemFooter extends StatelessWidget {
  final String formattedDate;
  final num weight;

  const RecordListItemFooter({super.key, required this.formattedDate, required this.weight});

  @override
  Widget build(BuildContext context) => Row(
    children: [
      const Icon(Icons.calendar_today, size: 20, color: Colors.black),
      const SizedBox(width: 6),
      Text(
        formattedDate,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      const Spacer(),
      Container(
        width: 68,
        height: 68,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            border: Border.all(color: Colors.amber, width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.20),
                blurRadius: 6,
                spreadRadius: 1,
                offset: const Offset(0, 2),
              ),
            ]),
        alignment: Alignment.center,
        child: Text(
          '$weight kg',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    ],
  );
}