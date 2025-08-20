import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:sherpoutmobile/common/dto/training_plan_dto.dart';
import 'package:sherpoutmobile/pages/training/plan/training_plan_form.dart';
import 'package:sherpoutmobile/services/training_plan_service.dart';

import '../../../../common/components/app_page.dart';
import '../../../../common/components/loading_component.dart';

class TrainingPlanEditPage extends StatefulWidget {
  final int id;

  const TrainingPlanEditPage({super.key, required this.id});

  @override
  State<TrainingPlanEditPage> createState() => _TrainingPlanEditPageState();
}

class _TrainingPlanEditPageState extends State<TrainingPlanEditPage> with SingleTickerProviderStateMixin {
  final TrainingPlanService _trainingPlanService = GetIt.instance<TrainingPlanService>();

  TrainingPlanDTO? _trainingPlan;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadTrainingPlan();
  }

  Future<void> _loadTrainingPlan() async {
    try {
      final trainingPlan = await _trainingPlanService.getById(widget.id);

      setState(() {
        _trainingPlan = trainingPlan;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Błąd ładowania planu treningowego: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Edytuj trening"),
        ),
        body: LoadingComponent(
            isLoading: _isLoading,
            error: _error,
            child: _trainingPlan != null
                ? AppPage(
                    child: TrainingPlanForm(
                    trainingPlan: _trainingPlan!,
                    isEdit: true,
                  ))
                : null
        )
    );
  }
}