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
    final exerciseName = record.exercise.name?.localized(context) ?? '';
    final formattedDate = DateFormat('dd.MM.yyyy').format(record.date);

    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              exerciseName,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ExerciseCover(
                  objectName: record.exercise.cover!.imagePath,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Row(
                    children: [
                      const Icon(Icons.calendar_today,
                          size: 40, color: Colors.black12),
                      const SizedBox(width: 6),
                      Text(formattedDate,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          )),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  width: 68,
                  height: 68,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.amber, width: 2),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '${record.value} kg',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
