import 'package:flutter/cupertino.dart';
import 'package:sherpoutmobile/common/dto/muscle.dart';
import 'package:sherpoutmobile/common/dto/translated_string_dto.dart';
import 'package:sherpoutmobile/common/string_extension.dart';

class ExerciseSummary extends StatelessWidget {
  final TranslatedStringDto name;
  final Muscle targetMuscle;
  final Set<Muscle>? supportMuscles;

  const ExerciseSummary(
      {super.key,
      required this.name,
      required this.targetMuscle,
      this.supportMuscles});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(name.localized(context),
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600)
        ),
        Text(targetMuscle.localized(context).capitalize(),
            style: TextStyle(fontSize: 18)
        ),
        if (supportMuscles != null)
          Text(
              supportMuscles!
                  .map((muscle) => muscle.localized(context).capitalize())
                  .join(', '),
              style: TextStyle(fontSize: 16)),
      ],
    );
  }
}
