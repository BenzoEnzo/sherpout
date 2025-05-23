import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:sherpoutmobile/common/dto/exercise_list_dto.dart';
import 'package:sherpoutmobile/common/dto/muscle_category.dart';
import 'package:sherpoutmobile/common/components/loading_component.dart';

import '../../../../common/components/debouncer.dart';
import '../../../../services/exercise_service.dart';
import '../../../common/components/search_input.dart';
import 'exercises_accordion.dart';
import 'exercises_sort_button.dart';

class ExercisesListPage extends StatefulWidget {
  const ExercisesListPage({super.key});

  @override
  State<ExercisesListPage> createState() => _ExercisesListPageState();
}

class _ExercisesListPageState extends State<ExercisesListPage> {
  final ExerciseService _exerciseService = GetIt.instance<ExerciseService>();

  final _debouncer = Debouncer(delay: Duration(milliseconds: 300));

  List<ExerciseListDto> _exercises = [];
  String _searchQuery = '';
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

      setState(() {
        _exercises = exercises;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Błąd ładowania ćwiczeń: $e';
        _isLoading = false;
      });
    }
  }

  void _onSearchChanged(String value) {
    _debouncer.run(() {
      setState(() {
        _searchQuery = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final groupedExercises = _groupExercises(_filterExercises(_exercises));

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
              ExercisesSortButton(),
              SizedBox(height: 16),
              SearchInput(
                  onChanged: _onSearchChanged,
                  hint: AppLocalizations.of(context)!.searchExercises
              ),
              SizedBox(height: 16),
              ...groupedExercises.entries.map((entry) {
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

  Map<MuscleCategory, List<ExerciseListDto>> _groupExercises(List<ExerciseListDto> exercises) {
    final map = <MuscleCategory, List<ExerciseListDto>>{};
    for (final ex in exercises) {
      final cat = ex.targetMuscle.category;
      map.putIfAbsent(cat, () => []).add(ex);
    }
    return map;
  }

  List<ExerciseListDto> _filterExercises(List<ExerciseListDto> exercises) {
    if (_searchQuery.isEmpty) return exercises;
    return exercises.where((ex) {
      final query = _searchQuery.toLowerCase();
      return ex.name.en.toLowerCase().contains(query) || ex.name.pl.toLowerCase().contains(query);
    }).toList();
  }
}
