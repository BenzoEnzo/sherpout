enum ExerciseEquipment {
  barbell,
  dumbell,
  kettlebell,
  resistanceBand,
  machine,
  cableMachine,
  platform,
  bench,
  pullUpBar;

  static ExerciseEquipment? fromName(String name) {
    return ExerciseEquipment.values.firstWhere(
          (e) => e.name.toUpperCase() == name.replaceAll("_", ""),
    );
  }
}