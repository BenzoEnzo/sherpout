import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';

import '../../dto/translated_string_dto.dart';

class TranslatedStringField extends StatefulWidget {
  final String label;
  final TranslatedStringDto initialValue;
  final void Function(TranslatedStringDto) onChanged;
  final bool isRequired;

  final int maxLength;
  final int maxLines;

  const TranslatedStringField({super.key,
    required this.label,
    required this.initialValue,
    required this.onChanged,
    required this.isRequired,
    required this.maxLength,
    this.maxLines = 1
  });

  @override
  _TranslatedStringFieldState createState() => _TranslatedStringFieldState();
}

class _TranslatedStringFieldState extends State<TranslatedStringField> {
  late TextEditingController _enController;
  late TextEditingController _plController;

  final List<String> _languages = ["en", "pl"];
  int _currentLangIndex = 0;

  @override
  void initState() {
    super.initState();
    _enController = TextEditingController(text: widget.initialValue.en ?? "");
    _plController = TextEditingController(text: widget.initialValue.pl ?? "");

    _enController.addListener(_notifyChange);
    _plController.addListener(_notifyChange);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final systemLang = Localizations.localeOf(context).languageCode;
    _currentLangIndex = _languages.indexOf(systemLang);
  }

  void _notifyChange() {
    widget.onChanged(
      TranslatedStringDto(
        en: _enController.text,
        pl: _plController.text,
      ),
    );
  }

  @override
  void dispose() {
    _enController.dispose();
    _plController.dispose();
    super.dispose();
  }

  void _switchLanguage() {
    setState(() {
      _currentLangIndex = (_currentLangIndex + 1) % _languages.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    final label = widget.label;
    final currentLang = _languages[_currentLangIndex];
    final controller = currentLang == "en" ? _enController : _plController;

    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(label: Text(label)),
            validator: (value) => validate(context),
            maxLength: widget.maxLength,
            maxLines: widget.maxLines,
          ),
        ),
        SizedBox(width: 8),
        CountryFlag.fromLanguageCode(currentLang, shape: Circle(), width: 30),
        IconButton(
          icon: const Icon(Icons.arrow_forward_ios),
          onPressed: _switchLanguage,
        ),
      ],
    );
  }

  String? validate(BuildContext context) {
    if (widget.isRequired) {
      final isEmptyEn = (_enController.text.isEmpty);
      final isEmptyPl = (_plController.text.isEmpty);

      if (isEmptyEn && isEmptyPl) {
        return "At least one language has to be set.";
      }
    }
    return null;
  }
}