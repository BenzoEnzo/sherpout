import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:sherpoutmobile/common/dto/exercise_dto.dart';
import 'package:sherpoutmobile/pages/exercises/detail/exercise_detail.dart';

import '../../../common/components/loading_component.dart';
import '../../../common/components/app_page.dart';
import '../../../services/exercise_service.dart';

class ExerciseDetailPage extends StatefulWidget {
  final int id;

  const ExerciseDetailPage({super.key, required this.id});

  @override
  State<ExerciseDetailPage> createState() => _ExerciseDetailPageState();
}

class _ExerciseDetailPageState extends State<ExerciseDetailPage> with SingleTickerProviderStateMixin {
  final ExerciseService _exerciseService = GetIt.instance<ExerciseService>();

  ExerciseDto? _exercise;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadExercise();
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
          child: _exercise != null
              ? AppPage(child: ExerciseDetail(exercise: _exercise!))
              : null
        )
    );
  }
}