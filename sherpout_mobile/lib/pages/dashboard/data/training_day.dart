import 'package:sherpout_mobile/pages/dashboard/data/training_day_status.dart';
import 'package:sherpout_mobile/pages/dashboard/data/weekday.dart';

class TrainingDay {
  List<String> exercises;
  TrainingDayStatus status;
  Weekday day;

  TrainingDay(this.exercises, this.status, this.day);
}