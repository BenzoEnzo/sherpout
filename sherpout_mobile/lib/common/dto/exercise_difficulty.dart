enum ExerciseDifficulty {
  user,
  trainer,
  admin;

  static ExerciseDifficulty? fromName(String name) {
    return ExerciseDifficulty.values.firstWhere(
      (e) => e.name.toLowerCase() == name.toLowerCase(),
    );
  }
}
