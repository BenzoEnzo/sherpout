enum Language {
  english(name: "English", code: "en"),
  polish(name: "Polish", code: "pl");

  final String name;
  final String code;

  const Language({
    required this.name,
    required this.code
  });
}