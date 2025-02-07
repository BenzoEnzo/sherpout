import 'package:flutter/material.dart';
import 'package:sherpout_mobile/pages/dashboard/components/training_day_card.dart';
import 'package:sherpout_mobile/pages/dashboard/data/training_day_status.dart';
import 'package:sherpout_mobile/pages/dashboard/data/weekday.dart';

import '../data/training_day.dart';

class TrainingWeek extends StatelessWidget {
  final List<TrainingDay> trainingDays = [
    TrainingDay(["Exercise 1", "Exercise 2", "Exercise 3", "Exercise 4"], TrainingDayStatus.cancelled, Weekday.monday),
    TrainingDay(["Exercise 1", "Exercise 2", "Exercise 3"], TrainingDayStatus.finished, Weekday.tuesday),
    TrainingDay(["Exercise 1", "Exercise 2", "Exercise 3", "Exercise 4"], TrainingDayStatus.finished, Weekday.wednesday),
    TrainingDay(["Exercise 1", "Exercise 2", "Exercise 3", "Exercise 3", "Exercise 5"], TrainingDayStatus.upcoming, Weekday.thursday),
    TrainingDay(["Exercise 1", "Exercise 2", "Exercise 3", "Exercise 4"], TrainingDayStatus.upcoming, Weekday.friday),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: trainingDays.length,
          itemBuilder: (context, index) {
            return TrainingDayCard(trainingDay: trainingDays[index]);
          }
      ),
    );
  }

}