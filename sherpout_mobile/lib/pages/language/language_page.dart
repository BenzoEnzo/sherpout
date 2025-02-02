import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguagePage extends StatelessWidget {
  LanguagePage({super.key});

  final List languages = ['Polish', 'English'];

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
              dropdownMenuEntries: languages
                  .map((language) =>
                      DropdownMenuEntry(value: language, label: language))
                  .toList(),
              onSelected: (value) async {
                final prefs = await SharedPreferences.getInstance();
                await prefs.setString('selected_language', value);
                Navigator.pushReplacementNamed(context, '/dashboard');
              },
            ),
          ],
        ),
      ),
    );
  }
}
