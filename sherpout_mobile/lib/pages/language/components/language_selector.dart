import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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
          final FlutterSecureStorage secureStorage = FlutterSecureStorage();
          String? token = await secureStorage.read(key: "access_token");
          if (token != null) {
            Navigator.pushReplacementNamed(context, '/dashboard');
          }
          Navigator.pushReplacementNamed(context, '/auth');
        }
      },
    );
  }
}