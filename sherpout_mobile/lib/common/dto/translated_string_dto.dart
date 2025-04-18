class TranslatedStringDto {
  final String en;
  final String pl;

  TranslatedStringDto({
    required this.en,
    required this.pl,
  });

  factory TranslatedStringDto.fromJson(Map<String, dynamic> json) {
    return TranslatedStringDto(
      en: json['en'] as String,
      pl: json['pl'] as String,
    );
  }
}
