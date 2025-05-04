import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:sherpoutmobile/common/dto/exercise_dto.dart';
import 'package:sherpoutmobile/pages/exercises/detail/exercise_description.dart';
import 'package:sherpoutmobile/pages/exercises/detail/exercise_equipment_list.dart';
import 'package:sherpoutmobile/pages/exercises/detail/exercise_media_carousel.dart';
import 'package:sherpoutmobile/pages/exercises/list/exercise_cover_with_difficulty.dart';

import '../../../common/components/loading_component.dart';
import '../../../common/components/sherpout_page.dart';
import '../../../common/theme/app_colors.dart';
import '../../../services/exercise_service.dart';
import '../list/exercise_summary.dart';

class ExercisePage extends StatefulWidget {
  final int id;

  const ExercisePage({super.key, required this.id});

  @override
  State<ExercisePage> createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> with SingleTickerProviderStateMixin {
  final ExerciseService _exerciseService = GetIt.instance<ExerciseService>();

  ExerciseDto? _exercise;
  bool _isLoading = true;
  String? _error;

  late TabController tabController;

  @override
  void initState() {
    super.initState();
    _loadExercise();
    tabController = TabController(length: 3, vsync: this);
  }

  Future<void> _loadExercise() async {
    try {
      final exercise = await _exerciseService.getById(widget.id);

      setState(() {
        _exercise = exercise;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Błąd ładowania ćwiczeniaa: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.exercises),
        ),
        body: LoadingComponent(
          isLoading: _isLoading,
          error: _error,
          child: SherpoutPage(
              child: Column(
                children: [
                  Row(
                      children: [
                        ExerciseCoverWithDifficulty(
                            difficulty: _exercise!.difficulty,
                            cover: _exercise!.cover
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: ExerciseSummary(
                              name: _exercise!.name,
                              targetMuscle: _exercise!.targetMuscle,
                              supportMuscles: _exercise!.supportMuscles
                          ),
                        )
                      ]

                  ),
                  SizedBox(height: 16),
                  TabBar(
                    controller: tabController,
                    labelStyle: TextStyle(fontSize: 16),
                    tabs: [
                      Tab(icon: Icon(Icons.home, size: 24), text: "Description"),
                      Tab(icon: Icon(Icons.star, size: 24), text: "Equipment"),
                      Tab(icon: Icon(Icons.settings, size: 24), text: "Media"),
                    ],
                    indicatorColor: AppColors.primary,
                    labelColor: AppColors.primary,
                    unselectedLabelColor: Colors.black,
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: tabController,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 16.0),
                          child: ExerciseDescription(description: _exercise!.description!)
                        ),
                        Expanded(child: ExerciseEquipmentList(equipments: _exercise!.equipments!)
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
              )
          )
        )
    );
  }
  
}