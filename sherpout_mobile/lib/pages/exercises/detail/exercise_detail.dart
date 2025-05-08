import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sherpoutmobile/common/dto/exercise_dto.dart';

import '../../../common/theme/app_colors.dart';
import '../list/exercise_cover_with_difficulty.dart';
import '../list/exercise_summary.dart';
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

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final ExerciseDto exercise = widget.exercise;

    return Column(
      children: [
        Row(
            children: [
              ExerciseCoverWithDifficulty(
                  difficulty: widget.exercise.difficulty,
                  cover: exercise.cover
              ),
              SizedBox(width: 16),
              Expanded(
                child: ExerciseSummary(
                    name: exercise.name,
                    targetMuscle: exercise.targetMuscle,
                    supportMuscles: exercise.supportMuscles
                ),
              )
            ]

        ),
        SizedBox(height: 16),
        TabBar(
          controller: tabController,
          labelStyle: TextStyle(fontSize: 16),
          tabs: [
            Tab(icon: Icon(Icons.info_outline, size: 24), text: "Description"),
            Tab(icon: Icon(Icons.backpack_outlined, size: 24), text: "Equipment"),
            Tab(icon: Icon(Icons.image, size: 24), text: "Media"),
          ],
          dividerColor: AppColors.secondary,
          indicatorColor: AppColors.primary,
          labelColor: AppColors.primary,
          unselectedLabelColor: AppColors.secondary,
        ),
        Expanded(
          child: TabBarView(
            controller: tabController,
            children: [
              Padding(
                  padding: EdgeInsets.only(top: 16.0),
                  child: ExerciseDescription(description: exercise.description!)
              ),
              Expanded(child: ExerciseEquipmentList(equipments: exercise.equipments!)
              ),
              Expanded(child: Padding(
                  padding: EdgeInsets.only(top:16.0),
                  child: ExerciseMediaCarousel()
              )
              )
            ],
          ),
        ),
      ],
    );
  }
}
