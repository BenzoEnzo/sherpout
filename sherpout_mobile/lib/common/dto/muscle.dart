import 'package:flutter/cupertino.dart';

import 'muscle_category.dart';

enum Muscle {
  upperChest(1, 'upper chest', 'górna część klatki', MuscleCategory.chest),
  midChest(2, 'mid chest', 'środkowa część klatki', MuscleCategory.chest),
  lowerChest(3, 'lower chest', 'dolna część klatki', MuscleCategory.chest),
  otherChest(4, 'other', 'pozostałe', MuscleCategory.chest),

  lats(5, 'lats', 'najszersze', MuscleCategory.back),
  midBack(6, 'mid back', 'środkowa część pleców', MuscleCategory.back),
  traps(7, 'traps', 'czworoboczny', MuscleCategory.back),
  lowerBack(8, 'lower back', 'dolna część pleców', MuscleCategory.back),
  otherBack(9, 'other', 'pozostałe', MuscleCategory.back),

  frontDelts(10, 'front delts', 'przód barków', MuscleCategory.delts),
  sideDelts(11, 'side delts', 'bok barków', MuscleCategory.delts),
  backDelts(12, 'rear delts', 'tył barków', MuscleCategory.delts),

  quads(13, 'quads', 'czworogłowe', MuscleCategory.legs),
  hamstrings(14, 'hamstrings', 'dwugłowe', MuscleCategory.legs),
  calves(15, 'calves', 'łydki', MuscleCategory.legs),
  glutes(16, 'glutes', 'pośladki', MuscleCategory.legs),

  upperAbs(17, 'upper abs', 'górna część brzucha', MuscleCategory.abs),
  lowerAbs(18, 'lower abs', 'dolna część brzucha', MuscleCategory.abs),
  obliques(19, 'obliques', 'skośne', MuscleCategory.abs);

  final int id;
  final String en;
  final String pl;
  final MuscleCategory category;

  const Muscle(this.id, this.en, this.pl, this.category);

  static Muscle? fromName(String name) {
    return Muscle.values.firstWhere(
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
