import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:sherpoutmobile/common/dto/exercise_select_dto.dart';
import 'package:sherpoutmobile/common/dto/record_dto.dart';
import 'package:sherpoutmobile/common/form/app_form.dart';
import 'package:sherpoutmobile/common/form/fields/app_form_date_input.dart';
import 'package:sherpoutmobile/pages/exercises/exercise_select_item.dart';
import 'package:sherpoutmobile/services/record_service.dart';

import '../../../common/form/fields/app_form_autocomplete.dart';
import '../../../common/form/fields/app_form_number_input.dart';
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
          if (!widget.isEdit) ...[
            AppFormAutocomplete<RecordDTO, ExerciseSelectDTO>(
              options: _exercises,
              label: AppLocalizations.of(context)!.exercise,
              isRequired: true,
              getValue: (dto) => dto.exercise,
              setValue: (dto, exercise) => dto.exercise = exercise,
              getDisplay: (value) => value.name.localized(context),
              optionViewBuilder: (context, value) => ExerciseSelectItem(exercise: value),
            ),
          ],
          AppFormNumberInput<RecordDTO>(
              label: AppLocalizations.of(context)!.weight,
              isRequired: true,
              getValue: (dto) => dto.value,
              setValue: (dto, value) => dto.value = value,
              isDecimal: true,
          ),
          AppFormDateInput<RecordDTO>(
              label: AppLocalizations.of(context)!.date,
              isRequired: true,
              getValue: (dto) => dto.date,
              setValue: (dto, date) => dto.date = date,
              lastDate: DateTime.now(),
          ),
        ]
    );
  }

  Future<void> _onSubmit(RecordDTO toSave) async {
    setState(() {
      isLoading = true;
    });

    widget.isEdit ? _onEditSubmit(toSave) : _onCreateSubmit(toSave);

    setState(() {
      isLoading = false;
    });
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