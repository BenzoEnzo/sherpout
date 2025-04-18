enum MuscleCategory {
  chest('chest', 'klata'),
  back('back', 'plecy'),
  delts('delts', 'barki'),
  arms('arms', 'ramiona'),
  legs('legs', 'nogi'),
  abs('abs', 'brzuch');

  final String en;
  final String pl;

  const MuscleCategory(this.en, this.pl);

  static MuscleCategory? fromName(String name) {
    return MuscleCategory.values.firstWhere(
      (e) => e.name.toLowerCase() == name.toLowerCase(),
    );
  }
}
