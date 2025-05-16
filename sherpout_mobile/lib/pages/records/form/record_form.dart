import 'package:flutter/cupertino.dart';
import 'package:sherpoutmobile/common/dto/exercise_select_dto.dart';
import 'package:sherpoutmobile/common/dto/record_dto.dart';
import 'package:sherpoutmobile/common/dto/translated_string_dto.dart';
import 'package:sherpoutmobile/common/form/app_form.dart';
import 'package:sherpoutmobile/common/form/app_form_autocomplete.dart';
import 'package:sherpoutmobile/common/form/app_form_date_input.dart';
import 'package:sherpoutmobile/common/form/app_form_number_input.dart';
import 'package:sherpoutmobile/pages/exercises/exercise_select_item.dart';

class RecordForm extends StatelessWidget {
  final RecordDTO record;

  const RecordForm({super.key, required this.record});

  @override
  Widget build(BuildContext context) {
    return AppForm(
        dto: record,
        children: [
          AppFormAutocomplete(
            dto: record,
            options: [
              ExerciseSelectDTO(
                  id: 1, name: TranslatedStringDto(en: "en", pl: "pl")),
              ExerciseSelectDTO(
                  id: 2, name: TranslatedStringDto(en: "en 2", pl: "pl 2")),
            ],
            labelText: "Exercise",
            isRequired: true,
            getValue: (dto) => dto.exercise,
            setValue: (dto, exercise) => dto.exercise = exercise,
            getDisplay: (value) => value.name.localized(context),
            optionViewBuilder: (context, value) => ExerciseSelectItem(exercise: value),
          ),
          AppFormNumberInput(
              dto: record,
              label: "Weight",
              getValue: (dto) => dto.value,
              setValue: (dto, value) => dto.value = value,
              isDecimal: true,
          ),
          AppFormDateInput(
              dto: record,
              label: "Date",
              getValue: (dto) => dto.date,
              setValue: (dto, date) => dto.date = date,
              lastDate: DateTime.now(),
          )
        ],
        onSubmit: (toSave) => print("${toSave.value}-----${toSave.date}-----${toSave.exercise!.id}")
    );
  }

}