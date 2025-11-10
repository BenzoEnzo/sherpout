import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:sherpoutmobile/common/dto/training_plan_dto.dart';
import 'package:sherpoutmobile/pages/training/plan/list/training_plan_list_item.dart';
import 'package:sherpoutmobile/services/training_plan_service.dart';
import 'package:sherpoutmobile/common/components/loading_component.dart';

import '../../../../common/components/app_page.dart';
import '../../../../common/components/buttons/app_text_and_icon_button.dart';

class TrainingPlansPage extends StatefulWidget {
  const TrainingPlansPage({super.key});

  @override
  State<TrainingPlansPage> createState() => _TrainingPlansPageState();
}

class _TrainingPlansPageState extends State<TrainingPlansPage> {
  final TrainingPlanService _trainingPlanService =
      GetIt.instance<TrainingPlanService>();
  List<TrainingPlanDTO> _trainingPlans = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadTrainingPlans();
  }

  Future<void> _loadTrainingPlans() async {
    try {
      final trainingPlans = await _trainingPlanService.getAll();
      setState(() {
        _trainingPlans = trainingPlans;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'NIE DZIALA';
        _isLoading = false;
      });
    }
  }

  Future<void> _onAddNew() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.createNewTrainingPlan),
      ),
      body: LoadingComponent(
          isLoading: _isLoading,
          error: _error,
          child: AppPage(
              child: ListView.builder(
            itemCount: _trainingPlans.length,
            itemBuilder: (context, index) {
              return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: TrainingPlanItem(trainingPlan: _trainingPlans[index]));
            },
          ))),
      floatingActionButton: AppTextAndIconButton(
          text: AppLocalizations.of(context)!.addNew,
          icon: Icons.add,
          onPressed: () => _onAddNew()),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
