import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:sherpoutmobile/common/dto/exercise_list_dto.dart';
import 'package:sherpoutmobile/common/dto/muscle_category.dart';
import 'package:sherpoutmobile/component/loading_component.dart';
import 'package:sherpoutmobile/pages/activity/exercise_service.dart';
import 'package:sherpoutmobile/pages/activity/exercises_accordion.dart';
import 'package:sherpoutmobile/pages/activity/exercises_filter_button.dart';
import 'package:sherpoutmobile/pages/activity/search_input.dart';

class ExercisesPage extends StatefulWidget {
  const ExercisesPage({super.key});

  @override
  State<ExercisesPage> createState() => _ExercisesPageState();
}

class _ExercisesPageState extends State<ExercisesPage> {
  final ExerciseService _exerciseService = GetIt.instance<ExerciseService>();

  Map<MuscleCategory, List<ExerciseListDto>>? _exerciseMap;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadExercises();
  }

  Future<void> _loadExercises() async {
    try {
      final exercises = await _exerciseService.getAll();

      final grouped = _groupExercisesByCategory(exercises);
      setState(() {
        _exerciseMap = grouped;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Błąd ładowania ćwiczeń: $e';
        _isLoading = false;
      });
    }
  }

  Map<MuscleCategory, List<ExerciseListDto>> _groupExercisesByCategory(List<ExerciseListDto> exercises) {
    final map = <MuscleCategory, List<ExerciseListDto>>{};
    for (final ex in exercises) {
      final cat = ex.targetMuscle.category;
      map.putIfAbsent(cat, () => []).add(ex);
    }
    return map;
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
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            children: [
              ExercisesFilterButton(),
              SizedBox(height: 16),
              SearchInput(),
              SizedBox(height: 16),
              ...?_exerciseMap?.entries.map((entry) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: ExercisesAccordion(
                    category: entry.key,
                    exercises: entry.value,
                  ),
                );
              }),
            ],
          ),
      )
    );
  }
}