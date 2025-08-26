import 'package:flutter/src/widgets/framework.dart';
import 'package:sherpoutmobile/common/dto/translated_string_dto.dart';

import '../../components/translated_string_field.dart';
import 'app_form_field.dart';

class AppFormTranslatedStringInput<T> extends AppFormField<T, TranslatedStringDto> {
  AppFormTranslatedStringInput({
    required String key,
    required String label,
    required TranslatedStringDto? Function(T dto) getValue,
    required void Function(T dto, TranslatedStringDto value) setValue,
    required bool isRequired,
  }) : super(key, label, getValue, setValue, isRequired);

  @override
  Widget build(BuildContext context, T dto, List<String>? errors) {
    final value = getValue(dto) ?? TranslatedStringDto(en: "", pl: null);

    return TranslatedStringField(
      label: label,
      initialValue: value,
      onChanged: (val) => setValue(dto, val),
      errors: errors,
    );
  }
}