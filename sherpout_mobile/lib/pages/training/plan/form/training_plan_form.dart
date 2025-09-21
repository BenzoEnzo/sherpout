import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:sherpoutmobile/common/components/field/translated_string_field.dart';
import 'package:sherpoutmobile/common/dto/training_plan_dto.dart';
import 'package:sherpoutmobile/common/dto/translated_string_dto.dart';
import 'package:sherpoutmobile/pages/training/plan/form/training_plan_form_days.dart';
import 'package:sherpoutmobile/services/training_plan_service.dart';

import '../../../../common/dto/training_plan_day_dto.dart';
import '../../../../common/form/app_form.dart';

class TrainingPlanForm extends StatefulWidget {
  final TrainingPlanDTO trainingPlan;
  final bool isEdit;

  const TrainingPlanForm(
      {super.key, required this.trainingPlan, this.isEdit = false});

  @override
  State<TrainingPlanForm> createState() => _TrainingPlanFormState();
}

class _TrainingPlanFormState extends State<TrainingPlanForm> {
  final TrainingPlanService _trainingPlanService =
      GetIt.instance<TrainingPlanService>();

  @override
  void initState() {
    super.initState();
  }

  void _addDay() {
    var dayNumber = widget.trainingPlan.days!.length + 1;
    setState(() {
      widget.trainingPlan.days?.add(TrainingPlanDayDTO(number: dayNumber));
    });
  }

  @override
  Widget build(BuildContext context) {
    final TrainingPlanDTO trainingPlan = widget.trainingPlan;

    return AppForm(
        dto: trainingPlan,
        onSubmit: widget.isEdit ? _onEditSubmit : _onCreateSubmit,
        children: [
          TranslatedStringField(
            label: "Name",
            initialValue: trainingPlan.name ?? TranslatedStringDto(),
            onChanged: (value) => trainingPlan.name = value,
            isRequired: true,
          ),
          TranslatedStringField(
            label: "Description",
            initialValue: trainingPlan.name ?? TranslatedStringDto(),
            onChanged: (value) => trainingPlan.name = value,
            isRequired: false,
          ),
          TrainingPlanFormDays(
            addDay: _addDay,
            days: trainingPlan.days ?? [],
          )
        ]);
  }

  Future<void> _onCreateSubmit(TrainingPlanDTO toCreate) async {
    print("Jebac ${toCreate.toJson()}");
    // TrainingPlanDTO result = await _trainingPlanService.create(toCreate);

    if (!mounted) return;

    //TODO redirect to training plan page if success
    // context.push("training-plans/${result.id}");
  }

  Future<void> _onEditSubmit(TrainingPlanDTO toEdit) async {
    await _trainingPlanService.update(toEdit);

    if (!mounted) return;

    context.pop();
  }
}
