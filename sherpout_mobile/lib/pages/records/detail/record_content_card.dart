import 'package:flutter/material.dart';

import '../../../../common/theme/app_colors.dart';

class RecordContentCard extends StatelessWidget {
  const RecordContentCard({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.secondary, width: 1),
      ),
      child: child,
    );
  }
}
