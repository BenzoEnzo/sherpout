import 'package:flutter/material.dart';
import 'package:sherpoutmobile/common/theme/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppFormAutocomplete<DTO, T extends Object> extends StatelessWidget {
  final DTO dto;
  final List<T> options;
  final String label;
  final bool isRequired;

  final T? Function(DTO dto) getValue;
  final void Function(DTO dto, T value) setValue;
  final String Function(T) getDisplay;
  final Widget Function(BuildContext, T) optionViewBuilder;

  const AppFormAutocomplete(
      {super.key,
      required this.dto,
      required this.options,
      required this.label,
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
        fieldViewBuilder:
            (context, textEditingController, focusNode, onEditingComplete) {
          textEditingController.text = controller.text;
          return TextFormField(
            controller: textEditingController,
            focusNode: focusNode,
            decoration: InputDecoration(
              labelText: label,
            ),
            validator: (value) => _validate(value, context),
            onEditingComplete: onEditingComplete,
          );
        },
        onSelected: (T value) {
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

  String? _validate(String? value, BuildContext context) {
    if (isRequired && (value?.isEmpty ?? true)) {
      return AppLocalizations.of(context)!.thisFieldIsRequired;
    }
    return null;
  }
}
