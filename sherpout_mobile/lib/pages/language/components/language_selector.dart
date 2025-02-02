import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../objects/language.dart';

class LanguageSelector extends StatelessWidget {
  final Function(Language) setLocale;

  const LanguageSelector({super.key, required this.setLocale});

  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      hintText: 'Language',
      dropdownMenuEntries: Language.values
          .map((language) => DropdownMenuEntry(value: language, label: language.name))
          .toList(),
      onSelected: (value) async {
        if (value != null) {
          setLocale(value);
          Navigator.pushReplacementNamed(context, '/dashboard');
        }
      },
    );
  }
}