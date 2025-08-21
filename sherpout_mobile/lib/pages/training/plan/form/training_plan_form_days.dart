import 'package:flutter/material.dart';
import 'package:sherpoutmobile/common/components/buttons/app_text_button.dart';
import 'package:sherpoutmobile/common/components/tab_bar/app_tab_bar.dart';
import 'package:sherpoutmobile/common/dto/training_plan_day_dto.dart';

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
            (entry) => Center(child: Text("Treść dnia ${entry.key + 1}")),
      ),
    ];

    return Row(
      children: [
        Expanded(
          child: AppTabBar(tabController: tabController, tabs: tabs),
        ),
        if (widget.days.length < 7)
          AppTextButton(text: "+", onPressed: _handleAddDay),
      ],
    );
    
    // return Column(
    //   children: [
    //     AppTabBar(tabController: tabController, tabs: tabs),
    //     AppTabBarView(tabController: tabController, children: children)
    //   ],
    // );
  }
}
