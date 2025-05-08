import 'package:flutter/material.dart';

class AppTabBarView extends StatelessWidget {
  final TabController tabController;
  final List<Widget> children;

  const AppTabBarView({super.key, required this.tabController, required this.children});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TabBarView(
        controller: tabController,
        children: children,
      ),
    );
  }
}
