import 'package:flutter/cupertino.dart';

class TranslatedStringDto {
  String? en;
  String? pl;

  TranslatedStringDto({
    this.en,
    this.pl,
  });

  factory TranslatedStringDto.fromJson(Map<String, dynamic> json) {
    return TranslatedStringDto(
      en: json['en'] != null ? json['en'] as String : null,
      pl: json['pl'] != null ? json['pl'] as String : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (en != null) 'en': en,
      if (pl != null) 'pl': pl,
    };
  }

  String localized(BuildContext context) {
    final lang = Localizations.localeOf(context).languageCode;

    switch (lang) {
      case 'pl':
        return pl ?? en ?? '';
      case 'en':
      default:
        return en ?? pl ?? '';
    }
  }
}
