import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sherpoutmobile/common/dto/record_dto.dart';
import '../../exercises/list/exercise_cover.dart';

class RecordItem extends StatelessWidget {
  final RecordDTO record;

  const RecordItem({
    super.key,
    required this.record,
  });

  @override
  Widget build(BuildContext context) {
    final exerciseName = record.exercise.name!.localized(context);
    final formattedDate = DateFormat('dd.MM.yyyy').format(record.date);
    final objectName = record.exercise.cover!.imagePath;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xffADC5EB), width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ExerciseCover(objectName: objectName),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _HeaderRow(exerciseName: exerciseName),
                const SizedBox(height: 8),
                _FooterRow(formattedDate: formattedDate, kg: record.value),
              ],
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.chevron_right),
        ],
      ),
    );
  }
}

class _HeaderRow extends StatelessWidget {
  final String exerciseName;

  const _HeaderRow({required this.exerciseName});

  @override
  Widget build(BuildContext context) => Text(
        exerciseName,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
      );
}

class _FooterRow extends StatelessWidget {
  final String formattedDate;
  final num kg;

  const _FooterRow({required this.formattedDate, required this.kg});

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
              '$kg kg',
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
