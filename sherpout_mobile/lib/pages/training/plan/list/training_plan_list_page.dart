import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:sherpoutmobile/common/dto/training_plan_dto.dart';
import 'package:sherpoutmobile/pages/training/plan/list/training_plan_footer.dart';
import 'package:sherpoutmobile/pages/training/plan/list/training_plan_header.dart';
import 'package:sherpoutmobile/pages/training/plan/list/training_plan_list_item.dart';
import 'package:sherpoutmobile/services/training_plan_service.dart';
import 'package:sherpoutmobile/common/components/loading_component.dart';

import '../../../../common/components/app_page.dart';
import '../../../../common/components/debouncer.dart';
import '../../../../common/components/search_input.dart';

class TrainingPlansPage extends StatefulWidget {
  const TrainingPlansPage({super.key});

  @override
  State<TrainingPlansPage> createState() => _TrainingPlansPageState();
}

class _TrainingPlansPageState extends State<TrainingPlansPage> {

  final _debouncer = Debouncer(delay: Duration(milliseconds: 300));

  final TrainingPlanService _trainingPlanService =
  GetIt.instance<TrainingPlanService>();
  List<TrainingPlanDTO> _trainingPlans = [];
  String _searchQuery = '';
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

  void _sortTrainingPlansByName() {}

  void _sortTrainingPlansByDate() {}

  void _onSearchChanged(String value) {
    _debouncer.run(() {
      setState(() {
        _searchQuery = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.trainingPlans),
      ),
      body: LoadingComponent(
        isLoading: _isLoading,
        error: _error,
        child: AppPage(
          child: ListView(
            padding:
            const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            children: [
              TrainingPlanHeader(
                onSortSelected: (index) {
                  if (index == 0) {
                    _sortTrainingPlansByName();
                  } else {
                    _sortTrainingPlansByDate();
                  }
                },
              ),
              const SizedBox(height: 16),
              // 🌟 Search input
              SearchInput(
                hint: AppLocalizations.of(context)!.searchTrainingPlans,
                onChanged: _onSearchChanged,
              ),
              const SizedBox(height: 16),
              ..._trainingPlans.map(
                    (plan) =>
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: TrainingPlanItem(trainingPlan: plan),
                    ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton:
      TrainingPlanFooter(onReload: _loadTrainingPlans),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  List<TrainingPlanDTO> _filterTrainingPlans(List<TrainingPlanDTO> trainingPlans,
      BuildContext context) {
    if (_searchQuery.isEmpty) return trainingPlans;
    return trainingPlans.where((trainingPlan) {
      final query = _searchQuery.toLowerCase();
      return trainingPlan.name!.localized(context).contains(query);
    }).toList();
  }
}
