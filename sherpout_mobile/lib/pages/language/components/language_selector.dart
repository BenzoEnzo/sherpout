import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../common/auth_service.dart';
import '../objects/language.dart';

class LanguageSelector extends StatelessWidget {
  final AuthService _authService = GetIt.instance<AuthService>();

  final Function(Language) setLocale;

  LanguageSelector({super.key, required this.setLocale});

  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      hintText: 'Language',
      dropdownMenuEntries: Language.values
          .map((language) => DropdownMenuEntry(value: language, label: language.name))
          .toList(),
      onSelected: (value) => selectLanguage(context, value)
    );
  }

  Future<void> selectLanguage(BuildContext context, Language? value) async {
    if (value == null) {
      return;
    }
    setLocale(value);
    bool loggedIn = await _authService.isUserLoggedIn();

    if (!context.mounted) {
      return;
    }
    context.go(loggedIn ? '/dashboard' : '/auth');
  }
}