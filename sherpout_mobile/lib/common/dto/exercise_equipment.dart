import 'package:flutter/cupertino.dart';

enum ExerciseEquipment {
  barbell("barbell", "sztanga"),
  dumbell("dumbell", "hantel"),
  kettlebell("kettlebell", "odważnik"),
  resistanceBand("resistance band", "guma oporowa"),
  machine("machine", "maszyna"),
  cableMachine("cable machine", "wyciąg"),
  platform("platform", "platforma"),
  bench("bench", "ławka"),
  pullUpBar("pull-up bar", "drążek");

  final String en;
  final String pl;

  const ExerciseEquipment(this.en, this.pl);

  static ExerciseEquipment? fromName(String name) {
    return ExerciseEquipment.values.firstWhere(
          (e) => e.name.toUpperCase() == name.replaceAll("_", ""),
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