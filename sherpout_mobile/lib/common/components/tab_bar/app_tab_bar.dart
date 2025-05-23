import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

class AppTabBar extends StatelessWidget {
  final TabController tabController;
  final List<Tab> tabs;

  const AppTabBar({super.key, required this.tabController, required this.tabs});

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: tabController,
      labelStyle: TextStyle(fontSize: 16),
      tabs: tabs,
      dividerColor: AppColors.secondary,
      indicatorColor: AppColors.primary,
      labelColor: AppColors.primary,
      unselectedLabelColor: AppColors.secondary,
    );
  }

}