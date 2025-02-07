import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension AppLocalizationsExtension on AppLocalizations {
  String getTranslation(String key) {
    final map = {
      "monday": monday,
      "mondayShortcut": mondayShortcut,
      "tuesday": tuesday,
      "tuesdayShortcut": tuesdayShortcut,
      "wednesday": wednesday,
      "wednesdayShortcut": wednesdayShortcut,
      "thursday": thursday,
      "thursdayShortcut": thursdayShortcut,
      "friday": friday,
      "fridayShortcut": fridayShortcut,
      "saturday": saturday,
      "saturdayShortcut": saturdayShortcut,
      "sunday": sunday,
      "sundayShortcut": sundayShortcut,
    };
    return map[key] ?? key;
  }
}