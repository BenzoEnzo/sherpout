import 'package:flutter/cupertino.dart';

enum ExerciseDifficulty {
  easy("easy", "łatwe"),
  medium("medium", "średnie"),
  hard("hard", "trudne");

  final String en;
  final String pl;

  const ExerciseDifficulty(this.en, this.pl);

  static ExerciseDifficulty? fromName(String name) {
    return ExerciseDifficulty.values.firstWhere(
      (e) => e.name.toLowerCase() == name.toLowerCase(),
    );
  }

  String localized(BuildContext context) {
    final lang = Localizations.localeOf(context).languageCode;
    switch (lang) {
      case 'pl':
        return pl;
      case 'en':
      default:
        return en;
    }
  }
}
