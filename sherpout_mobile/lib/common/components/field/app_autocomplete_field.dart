import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../theme/app_colors.dart';

class AppAutocompleteField<T extends Object> extends StatelessWidget {
  final String label;
  final T? initialValue;
  final void Function(T value) setValue;
  final bool isRequired;
  final List<T> options;

  final String Function(T) getDisplay;
  final Widget Function(BuildContext, T) optionViewBuilder;

  const AppAutocompleteField(
      {super.key,
        required this.label,
        required this.initialValue,
        required this.setValue,
        required this.isRequired,
        required this.options,
        required this.getDisplay,
        required this.optionViewBuilder
      });

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController(
      text: initialValue != null ? getDisplay(initialValue!) : '',
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
            decoration: InputDecoration(label: Text(label)),
            validator: (value) => validateRequired(value, context),
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

  String? validateRequired(String? value, BuildContext context) {
    if (isRequired && (value?.isEmpty ?? true)) {
      return AppLocalizations.of(context)!.thisFieldIsRequired;
    }
    return null;
  }
}