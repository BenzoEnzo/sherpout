import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:sherpoutmobile/common/components/field/app_autocomplete_field.dart';
import 'package:sherpoutmobile/common/components/field/app_date_field.dart';
import 'package:sherpoutmobile/common/components/field/app_number_field.dart';
import 'package:sherpoutmobile/common/dto/exercise_select_dto.dart';
import 'package:sherpoutmobile/common/dto/record_dto.dart';
import 'package:sherpoutmobile/pages/exercises/exercise_select_item.dart';
import 'package:sherpoutmobile/services/record_service.dart';

import '../../../common/components/form/app_form.dart';
import '../../../services/exercise_service.dart';

class RecordForm extends StatefulWidget {
  final RecordDTO record;
  final bool isEdit;

  const RecordForm({super.key, required this.record, this.isEdit = false});

  @override
  State<RecordForm> createState() => _RecordFormState();
}

class _RecordFormState extends State<RecordForm> {
  final ExerciseService _exerciseService = GetIt.instance<ExerciseService>();
  final RecordService _recordService = GetIt.instance<RecordService>();
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
    final RecordDTO record = widget.record;

    return AppForm(
        dto: record,
        onSubmit: widget.isEdit ? _onEditSubmit : _onCreateSubmit,
        children: [
          if (!widget.isEdit) ...[
            AppAutocompleteField<ExerciseSelectDTO>(
              options: _exercises,
              label: AppLocalizations.of(context)!.exercise,
              isRequired: true,
              initialValue: record.exercise,
              setValue: (exercise) => record.exercise = exercise,
              getDisplay: (value) => value.name.localized(context),
              optionViewBuilder: (context, value) =>
                  ExerciseSelectItem(exercise: value),
            ),
          ],
          AppNumberField(
            label: AppLocalizations.of(context)!.weight,
            isRequired: true,
            initialValue: record.value,
            setValue: (value) => record.value = value,
            isDecimal: true,
            min: 1,
            max: 1000
          ),
          AppDateField(
            label: AppLocalizations.of(context)!.date,
            isRequired: true,
            initialValue: record.date,
            setValue: (date) => record.date = date,
            lastDate: DateTime.now(),
          ),
        ]);
  }

  Future<void> _onCreateSubmit(RecordDTO toCreate) async {
    RecordDTO result = await _recordService.create(toCreate);

    if (!mounted) return;

    //TODO redirect to record page if success
    // context.push("records/${result.id}");
  }

  Future<void> _onEditSubmit(RecordDTO toEdit) async {
    await _recordService.update(toEdit);

    if (!mounted) return;

    context.pop();
  }
}
