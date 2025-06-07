import 'package:flutter/cupertino.dart';
import 'package:sherpoutmobile/common/dto/translated_string_dto.dart';

class ExerciseDescription extends StatelessWidget {
  final TranslatedStringDto description;

  const ExerciseDescription({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    return Text(description.localized(context),
        style: TextStyle(fontSize: 16)
    );
  }
}
