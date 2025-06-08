import 'package:flutter/cupertino.dart';
import 'package:sherpoutmobile/common/dto/translated_string_dto.dart';

import '../../../common/theme/app_typography.dart';

class RecordListItemHeader extends StatelessWidget {
  final TranslatedStringDto exerciseName;

  const RecordListItemHeader({super.key, required this.exerciseName});

  @override
  Widget build(BuildContext context) =>
      Text(exerciseName.localized(context), style: AppTypography.titleLarge);
}
