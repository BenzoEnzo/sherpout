import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'language.dart';

class LanguagePage extends StatelessWidget {
  final Function(Language) setLocale;

  const LanguagePage({super.key, required this.setLocale});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Choose language:', style: TextStyle(fontSize: 24)),
            DropdownMenu(
              hintText: 'Language',
              dropdownMenuEntries: Language.values
                  .map((language) =>
                      DropdownMenuEntry(value: language, label: language.name))
                  .toList(),
              onSelected: (value) async {
                if (value != null) {
                  setLocale(value);
                  Navigator.pushReplacementNamed(context, '/dashboard');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
