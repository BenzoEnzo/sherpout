import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:sherpoutmobile/common/dto/training_plan_dto.dart';
import 'package:sherpoutmobile/pages/training/plan/form/training_plan_form.dart';

import '../../../../common/components/app_page.dart';
import '../../../../services/training_plan_service.dart';

class TrainingPlanDetailPage extends StatefulWidget {
  final TrainingPlanDTO trainingPlan;

  const TrainingPlanDetailPage({super.key, required this.trainingPlan});

  @override
  State<TrainingPlanDetailPage> createState() => _TrainingPlanDetailPageState();
}

class _TrainingPlanDetailPageState extends State<TrainingPlanDetailPage> {

  final TrainingPlanService _trainingPlanService = GetIt.instance<TrainingPlanService>();
  late final Future<TrainingPlanDTO> _futurePlan = _trainingPlanService.getById(widget.trainingPlan.id!);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.detailTrainingPlan),
      ),
      body: AppPage(
        child: FutureBuilder<TrainingPlanDTO>(
          future: _futurePlan,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Błąd: ${snapshot.error}'));
            } else {
              final trainingPlan = snapshot.data!;

              return TrainingPlanForm(
                trainingPlan: trainingPlan,
                viewOnly: true,
              );
            }
          },
        ),
      ),
    );
  }
}