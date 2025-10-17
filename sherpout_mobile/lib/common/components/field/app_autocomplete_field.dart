import 'package:flutter/material.dart';
import 'package:sherpoutmobile/common/components/field/app_field_stateless_widget.dart';

import '../../theme/app_colors.dart';

class AppAutocompleteField<T extends Object> extends AppFieldStatelessWidget<T> {
  final List<T> options;
  final String Function(T) getDisplay;
  final Widget Function(BuildContext, T) optionViewBuilder;

  const AppAutocompleteField({
    super.key,
    required super.label,
    required super.initialValue,
    required super.setValue,
    required super.isRequired,
    required this.options,
    required this.getDisplay,
    required this.optionViewBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Autocomplete<T>(
        initialValue: TextEditingValue(
          text: initialValue != null ? getDisplay(initialValue!) : '',
        ),
        optionsBuilder: (TextEditingValue textEditingValue) {
          final input = textEditingValue.text.toLowerCase();
          return options.where(
            (T option) => getDisplay(option).toLowerCase().contains(input),
          );
        },
        displayStringForOption: getDisplay,
        fieldViewBuilder:
            (context, textEditingController, focusNode, onEditingComplete) {
          return TextFormField(
            controller: textEditingController,
            focusNode: focusNode,
            decoration: InputDecoration(label: Text(label)),
            validator: (value) => validate(value, context),
            onEditingComplete: onEditingComplete,
          );
        },
        onSelected: (T value) {
          setValue(value);
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
                    children: options.map((T option) {
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
