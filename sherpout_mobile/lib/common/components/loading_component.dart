import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class LoadingComponent extends StatelessWidget {
  final bool isLoading;
  final String? error;
  final Widget? child;

  const LoadingComponent({
    super.key,
    required this.isLoading,
    required this.error,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (error != null) {
      return Center(child: Text(error!, style: const TextStyle(color: AppColors.redAccent)));
    }

    return child ?? const SizedBox.shrink();
  }
}
