import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sherpoutmobile/pages/training/plan/form/training_plan_form_days.dart';

import '../../../../common/dto/training_plan_day_dto.dart';
import '../../../../common/form/fields/app_form_field.dart';

class TrainingPlanFormDaysField<T> extends AppFormField<T, List<TrainingPlanDayDTO>> {
  TrainingPlanFormDaysField({
    required String key,
    required String label,
    required List<TrainingPlanDayDTO>? Function(T dto) getValue,
    required void Function(T dto, List<TrainingPlanDayDTO> value) setValue,
    bool isRequired = false,
  }) : super(key, label, getValue, setValue, isRequired);

  @override
  Widget build(BuildContext context, T dto, List<String>? errors) {
    final days = getValue(dto) ?? [];

    return Expanded(
      child: TrainingPlanFormDays(days: days),
    );
  }
}