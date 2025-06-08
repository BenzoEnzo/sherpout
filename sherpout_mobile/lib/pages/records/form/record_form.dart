import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:sherpoutmobile/common/dto/exercise_select_dto.dart';
import 'package:sherpoutmobile/common/dto/record_dto.dart';
import 'package:sherpoutmobile/common/form/app_form.dart';
import 'package:sherpoutmobile/common/form/app_form_autocomplete.dart';
import 'package:sherpoutmobile/common/form/app_form_date_input.dart';
import 'package:sherpoutmobile/common/form/app_form_number_input.dart';
import 'package:sherpoutmobile/pages/exercises/exercise_select_item.dart';
import 'package:sherpoutmobile/services/record_service.dart';

import '../../../services/exercise_service.dart';

class RecordForm extends StatefulWidget {
  final RecordDTO record;

  const RecordForm({super.key, required this.record});

  @override
  State<RecordForm> createState() => _RecordFormState();
}

class _RecordFormState extends State<RecordForm> {
  final ExerciseService _exerciseService = GetIt.instance<ExerciseService>();
  final RecordService _recordService = GetIt.instance<RecordService>();
  List<ExerciseSelectDTO> _exercises = [];
  bool isLoading = false;

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
    final RecordDTO record = widget.record;

    return AppForm(
        dto: record,
        onSubmit: _onSubmit,
        isLoading: false,
        children: [
          AppFormAutocomplete(
            dto: record,
            options: _exercises,
            label: "Exercise",
            isRequired: true,
            getValue: (dto) => dto.exercise,
            setValue: (dto, exercise) => dto.exercise = exercise,
            getDisplay: (value) => value.name.localized(context),
            optionViewBuilder: (context, value) => ExerciseSelectItem(exercise: value),
          ),
          SizedBox(height: 24),
          AppFormNumberInput(
              dto: record,
              label: "Weight",
              isRequired: true,
              getValue: (dto) => dto.value,
              setValue: (dto, value) => dto.value = value,
              isDecimal: true,
          ),
          SizedBox(height: 24),
          AppFormDateInput(
              dto: record,
              label: "Date",
              isRequired: true,
              getValue: (dto) => dto.date,
              setValue: (dto, date) => dto.date = date,
              lastDate: DateTime.now(),
          ),
          SizedBox(height: 32),
        ]
    );
  }

  Future<void> _onSubmit(RecordDTO record) async {
    setState(() {
      isLoading = true;
    });
    await _recordService.create(record);
    //TODO redirect to record page if success
    setState(() {
      isLoading = false;
    });
  }

}