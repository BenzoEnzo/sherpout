import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:sherpoutmobile/common/dto/exercise_dto.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../common/components/loading_component.dart';
import '../../../services/exercise_service.dart';

class ExercisePage extends StatefulWidget {
  final int id;

  const ExercisePage({super.key, required this.id});

  @override
  State<ExercisePage> createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
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
        _error = 'Błąd ładowania ćwiczenia: $e';
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
          child: Center(
            child: Text(_exercise?.name.localized(context) ?? ""),
          )
        )
    );
  }
  
}