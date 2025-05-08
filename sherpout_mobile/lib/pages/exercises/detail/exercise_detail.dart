import 'package:flutter/material.dart';
import 'package:sherpoutmobile/common/components/tab_bar/app_tab_bar.dart';
import 'package:sherpoutmobile/common/components/tab_bar/app_tab_bar_view.dart';
import 'package:sherpoutmobile/common/dto/exercise_dto.dart';
import 'package:sherpoutmobile/pages/exercises/list/exercise_header.dart';

import 'exercise_description.dart';
import 'exercise_equipment_list.dart';
import 'exercise_media_carousel.dart';

class ExerciseDetail extends StatefulWidget {
  final ExerciseDto exercise;

  const ExerciseDetail({super.key, required this.exercise});

  @override
  State<ExerciseDetail> createState() => _ExerciseDetailState();
}

class _ExerciseDetailState extends State<ExerciseDetail> with SingleTickerProviderStateMixin {
  late TabController tabController;
  late List<Tab> tabs;
  late List<Widget> tabViews;

  @override
  void initState() {
    super.initState();
    _buildTabsAndViews(widget.exercise);
    tabController = TabController(length: tabs.length, vsync: this);
  }

  void _buildTabsAndViews(ExerciseDto exercise) {
    tabs = [Tab(icon: Icon(Icons.info_outline), text: "Description")];
    tabViews = [
      Padding(
        padding: EdgeInsets.only(top: 16.0),
        child: ExerciseDescription(description: exercise.description),
      )
    ];

    if (exercise.equipments != null && exercise.equipments!.isNotEmpty) {
      tabs.add(Tab(icon: Icon(Icons.backpack_outlined), text: "Equipment"));
      tabViews.add(ExerciseEquipmentList(equipments: exercise.equipments!));
    }

    if (exercise.images != null && exercise.images!.isNotEmpty) {
      tabs.add(Tab(icon: Icon(Icons.image), text: "Media"));
      tabViews.add(Padding(
        padding: EdgeInsets.only(top: 16.0),
        child: ExerciseMediaCarousel(images: exercise.images!),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final ExerciseDto exercise = widget.exercise;

    return Column(
      children: [
        ExerciseHeader(exercise: exercise.toListDto()),
        SizedBox(height: 16),
        AppTabBar(tabController: tabController, tabs: tabs),
        AppTabBarView(tabController: tabController, children: tabViews)
      ],
    );
  }
}
