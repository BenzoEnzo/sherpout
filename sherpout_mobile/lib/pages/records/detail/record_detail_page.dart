import 'package:flutter/material.dart';
import 'package:sherpoutmobile/pages/records/detail/record_history.dart';

import '../../../../common/dto/record_dto.dart';
import '../../../common/dto/date_range_query_param.dart';
import '../list/record_row_component.dart';

class RecordDetailPage extends StatefulWidget {
  const RecordDetailPage({
    super.key,
    required this.record,
    required this.range,
  });

  final RecordDTO record;
  final DateRangeQueryParam range;

  @override
  State<RecordDetailPage> createState() => _RecordDetailPageState();
}

class _RecordDetailPageState extends State<RecordDetailPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabs = TabController(length: 2, vsync: this);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Record history')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: RecordRowComponent(
              record: widget.record,
              showChevron: false,
              padding: const EdgeInsets.all(16),
            ),
          ),
          TabBar(
            controller: _tabs,
            tabs: const [
              Tab(icon: Icon(Icons.history), text: 'History'),
              Tab(icon: Icon(Icons.show_chart), text: 'Chart'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabs,
              children: [
                RecordHistory(
                  exerciseId: widget.record.exercise!.id!,
                  range: widget.range,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}