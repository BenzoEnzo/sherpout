import 'package:flutter/material.dart';
import 'package:sherpoutmobile/common/form/fields/app_form_field.dart';
import 'package:sherpoutmobile/common/theme/app_colors.dart';

class AppFormAutocomplete<T, V extends Object> extends AppFormField<T, V> {
  final List<V> options;

  final String Function(V) getDisplay;
  final Widget Function(BuildContext, V) optionViewBuilder;

  AppFormAutocomplete({
    required String label,
    required V? Function(T dto) getValue,
    required void Function(T dto, V value) setValue,
    required bool isRequired,
    required this.options,
    required this.getDisplay,
    required this.optionViewBuilder
  }) : super(label, getValue, setValue, isRequired);

  @override
  Widget build(BuildContext context, T dto) {
    final selectedValue = getValue(dto);
    final controller = TextEditingController(
      text: selectedValue != null ? getDisplay(selectedValue) : '',
    );

    return Autocomplete<V>(
        initialValue: TextEditingValue(text: controller.text),
        optionsBuilder: (TextEditingValue textEditingValue) {
          final input = textEditingValue.text.toLowerCase();
          return options.where(
            (V option) => getDisplay(option).toLowerCase().contains(input),
          );
        },
        displayStringForOption: getDisplay,
        fieldViewBuilder:
            (context, textEditingController, focusNode, onEditingComplete) {
          textEditingController.text = controller.text;
          return TextFormField(
            controller: textEditingController,
            focusNode: focusNode,
            decoration: InputDecoration(
              labelText: label,
            ),
            validator: (value) => validateRequired(value, context),
            onEditingComplete: onEditingComplete,
          );
        },
        onSelected: (V value) {
          setValue(dto, value);
        },
        optionsViewBuilder: (context, onSelected, options) {
          return Align(
            alignment: Alignment.topLeft,
            child: Material(
                color: AppColors.background,
                elevation: 4.0,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width - 65,
                  child: ListView(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    children: options.map((V option) {
                      return InkWell(
                        onTap: () => onSelected(option),
                        child: optionViewBuilder(context, option),
                      );
                    }).toList(),
                  ),
                )),
          );
        });
  }
}
