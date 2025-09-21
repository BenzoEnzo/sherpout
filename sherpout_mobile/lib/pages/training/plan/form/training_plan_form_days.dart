import 'package:flutter/material.dart';
import 'package:sherpoutmobile/common/components/tab_bar/app_tab_bar.dart';
import 'package:sherpoutmobile/common/components/tab_bar/app_tab_bar_view.dart';
import 'package:sherpoutmobile/common/dto/training_plan_day_dto.dart';
import 'package:sherpoutmobile/pages/training/plan/form/day/training_plan_day_form.dart';

class TrainingPlanFormDays extends StatefulWidget {
  final List<TrainingPlanDayDTO> days;

  const TrainingPlanFormDays({super.key, required this.days});

  @override
  State<TrainingPlanFormDays> createState() => _TrainingPlanFormDaysState();
}

class _TrainingPlanFormDaysState extends State<TrainingPlanFormDays> with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    _initController();
  }

  void _initController() {
    tabController = TabController(length: widget.days.length, vsync: this);
  }

  void _handleAddDay() {
    setState(() {
      widget.days.add(TrainingPlanDayDTO());
    });

    tabController = TabController(length: widget.days.length, vsync: this);
    tabController.animateTo(widget.days.length - 1);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Tab> tabs = [
      ...widget.days.asMap().entries.map(
            (entry) => Tab(text: "${entry.key + 1}"),
      ),
    ];

    final List<Widget> children = [
      ...widget.days.asMap().entries.map(
            (entry) => TrainingPlanDayForm(day: entry.value),
      ),
    ];

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: AppTabBar(tabController: tabController, tabs: tabs),
            ),
            if (widget.days.length < 7)
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: _handleAddDay,
              ),
          ],
        ),
        Expanded(
          child: AppTabBarView(
            tabController: tabController,
            children: children.map((dayForm) => SingleChildScrollView(
              padding: const EdgeInsets.all(8),
              child: dayForm,
            )).toList(),
          ),
        ),
      ],
    );
  }
}
