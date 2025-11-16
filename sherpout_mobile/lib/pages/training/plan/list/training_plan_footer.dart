import 'package:flutter/material.dart';
import 'package:sherpoutmobile/common/components/buttons/add_new_button.dart';

import '../create/training_plan_create_page.dart';

class TrainingPlanFooter extends StatelessWidget {
  final VoidCallback onReload;

  const TrainingPlanFooter({
    super.key,
    required this.onReload,
  });

  Future<void> _onAddNew(BuildContext context) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const TrainingPlanCreatePage(),
      ),
    );

    onReload();
  }

  @override
  Widget build(BuildContext context) {
    return AddNewButton(onPressed: () => _onAddNew(context));
  }
}