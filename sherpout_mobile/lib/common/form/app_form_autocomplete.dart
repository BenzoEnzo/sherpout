import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppFormAutocomplete<DTO, T extends Object> extends StatelessWidget {
  final DTO dto;
  final List<T> options;
  final String labelText;
  final bool isRequired;

  final T? Function(DTO dto) getValue;
  final void Function(DTO dto, T value) setValue;
  final String Function(T) getDisplay;
  final Widget Function(BuildContext, T) optionViewBuilder;

  const AppFormAutocomplete(
      {super.key,
      required this.dto,
      required this.options,
      required this.labelText,
      required this.isRequired,
      required this.getValue,
      required this.setValue,
      required this.getDisplay,
      required this.optionViewBuilder});

  @override
  Widget build(BuildContext context) {
    final selectedValue = getValue(dto);
    final controller = TextEditingController(
      text: selectedValue != null ? getDisplay(selectedValue) : '',
    );

    return Autocomplete<T>(
      initialValue: TextEditingValue(text: controller.text),
      optionsBuilder: (TextEditingValue textEditingValue) {
        final input = textEditingValue.text.toLowerCase();
        return options.where(
              (T option) => getDisplay(option).toLowerCase().contains(input),
        );
      },
      displayStringForOption: getDisplay,
      fieldViewBuilder: (context, textEditingController, focusNode, onEditingComplete) {
        textEditingController.text = controller.text;
        return TextFormField(
          controller: textEditingController,
          focusNode: focusNode,
          decoration: InputDecoration(
            labelText: labelText,
            border: const OutlineInputBorder(),
          ),
          validator: (value) {
            if (isRequired && (value?.isEmpty ?? true)) {
              return 'This field is required';
            }
            return null;
          },
          onEditingComplete: onEditingComplete,
        );
      },
      onSelected: (T value) {
        setValue(dto, value);
      },
      optionsViewBuilder: (context, onSelected, options) {
        return Material(
          elevation: 4,
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
        );
      },
    );
  }
}
