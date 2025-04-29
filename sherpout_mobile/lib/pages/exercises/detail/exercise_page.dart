import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:sherpoutmobile/common/dto/exercise_dto.dart';
import 'package:sherpoutmobile/pages/exercises/detail/exercise_equipment_item.dart';

import '../../../common/components/loading_component.dart';
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
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                ExerciseSummary(name: _exercise!.name, targetMuscle: _exercise!.targetMuscle),
                    SizedBox(height: 16),
                    TabBar(
                      controller: tabController,
                      tabs: [
                        Tab(icon: Icon(Icons.home), text: "Descriptionn"),
                        Tab(icon: Icon(Icons.star), text: "Equipment"),
                        Tab(icon: Icon(Icons.settings), text: "Media"),
                      ],
                      indicatorColor: const Color(0xff4B7FD2),
                      labelColor: const Color(0xff4B7FD2),
                      unselectedLabelColor: Colors.black,
                    ),
                Expanded(
                  child: TabBarView(
                    controller: tabController,
                    children: [
                      Text(_exercise?.description?.en ?? ""),
                    Expanded(child: ListView(
                      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                      children: [
                        ..._exercise?.equipments?.map((equipment) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: ExerciseEquipmentItem(equipment),
                          );
                        }) ?? [],
                      ],
                    ),),
                      Text('Zawartość Taba 3'),
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