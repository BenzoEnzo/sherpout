enum ExerciseDifficulty {
  easy,
  medium,
  hard;

  static ExerciseDifficulty? fromName(String name) {
    return ExerciseDifficulty.values.firstWhere(
      (e) => e.name.toLowerCase() == name.toLowerCase(),
    );
  }
}
