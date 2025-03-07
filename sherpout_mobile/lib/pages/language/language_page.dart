import 'package:flutter/material.dart';
import 'package:sherpoutmobile/pages/language/components/language_selector.dart';

import 'objects/language.dart';

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
            LanguageSelector(setLocale: setLocale)
          ],
        ),
      ),
    );
  }
}
