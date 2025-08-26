import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:sherpoutmobile/common/dto/training_plan_dto.dart';
import 'package:sherpoutmobile/common/form/fields/app_form_translated_string_input.dart';
import 'package:sherpoutmobile/pages/training/plan/form/training_plan_form_days_input.dart';
import 'package:sherpoutmobile/services/training_plan_service.dart';

import '../../../../common/form/app_form.dart';

class TrainingPlanForm extends StatefulWidget {
  final TrainingPlanDTO trainingPlan;
  final bool isEdit;

  const TrainingPlanForm({super.key, required this.trainingPlan, this.isEdit = false});

  @override
  State<TrainingPlanForm> createState() => _TrainingPlanFormState();
}

class _TrainingPlanFormState extends State<TrainingPlanForm> {
  final TrainingPlanService _trainingPlanService = GetIt.instance<TrainingPlanService>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final TrainingPlanDTO trainingPlan = widget.trainingPlan;

    return AppForm(
        dto: trainingPlan,
        onSubmit: widget.isEdit ? _onEditSubmit : _onCreateSubmit,
        children: [
          AppFormTranslatedStringInput(
              key: "name",
              label: "Name",
              getValue: (plan) => plan.name,
              setValue: (plan, value) => plan.name = value,
              isRequired: true
          ),
          AppFormTranslatedStringInput(
              key: "description",
              label: "Description",
              getValue: (plan) => plan.description,
              setValue: (plan, value) => plan.description = value,
              isRequired: true
          ),
          TrainingPlanFormDaysField(
              key: "days",
              label: "label",
              getValue: (dto) => dto.days,
              setValue: (dto, value) => dto.days = value
          )
            //exercisesList
            //addExercise
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