import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../dto/translated_string_dto.dart';

class TranslatedStringField extends StatefulWidget {
  final String label;
  final TranslatedStringDto initialValue;
  final void Function(TranslatedStringDto) onChanged;
  final List<String>? errors;

  const TranslatedStringField({super.key,
    required this.label,
    required this.initialValue,
    required this.onChanged,
    this.errors,
  });

  @override
  _TranslatedStringFieldState createState() => _TranslatedStringFieldState();
}

class _TranslatedStringFieldState extends State<TranslatedStringField> {
  late TextEditingController _enController;
  late TextEditingController _plController;

  @override
  void initState() {
    super.initState();
    _enController = TextEditingController(text: widget.initialValue.en ?? "");
    _plController = TextEditingController(text: widget.initialValue.pl ?? "");

    _enController.addListener(_notifyChange);
    _plController.addListener(_notifyChange);
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

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label),
        const SizedBox(height: 8),
        TextField(
          controller: _enController,
          decoration: const InputDecoration(labelText: "English"),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _plController,
          decoration: const InputDecoration(labelText: "Polish"),
        ),
      ],
    );
  }
}