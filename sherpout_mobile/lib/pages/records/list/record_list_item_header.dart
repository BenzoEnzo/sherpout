import 'package:flutter/cupertino.dart';

class RecordListItemHeader extends StatelessWidget {
  final String exerciseName;

  const RecordListItemHeader({super.key, required this.exerciseName});

  @override
  Widget build(BuildContext context) => Text(
    exerciseName,
    overflow: TextOverflow.ellipsis,
    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
  );
}