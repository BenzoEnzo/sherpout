import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:sherpoutmobile/common/components/buttons/app_text_button.dart';
import 'package:sherpoutmobile/common/dto/training_plan_day_dto.dart';

import '../../../../../common/dto/exercise_select_dto.dart';
import '../../../../../services/exercise_service.dart';

class TrainingPlanDayForm extends StatefulWidget {
  final TrainingPlanDayDTO day;

  const TrainingPlanDayForm({super.key, required this.day});

  @override
  State<TrainingPlanDayForm> createState() => _TrainingPlanDayFormState();
}

class _TrainingPlanDayFormState extends State<TrainingPlanDayForm> {
  final ExerciseService _exerciseService = GetIt.instance<ExerciseService>();
  List<ExerciseSelectDTO> _exercises = [];

  @override
  void initState() {
    super.initState();
    _loadExercises();
  }

  Future<void> _loadExercises() async {
    final exercises = await _exerciseService.getSelects();
    setState(() {
      _exercises = exercises;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppTextButton(text: "Remove day", onPressed: () => {});
  }
}