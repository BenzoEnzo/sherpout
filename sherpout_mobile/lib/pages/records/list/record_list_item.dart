import 'package:flutter/material.dart';

import '../../../../common/dto/record_dto.dart';
import '../../../common/dto/date_range_query_param.dart';
import '../detail/record_detail_page.dart';
import 'record_row_component.dart';

class RecordItem extends StatelessWidget {
  const RecordItem({
    super.key,
    required this.record,
  });

  final RecordDTO record;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      key: ValueKey(record.id),
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        final range = DateRangeQueryParam(
          from: DateTime(1978, 9, 17, 7, 30),
          to: DateTime.now(),
        );
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => RecordDetailPage(
              record: record,
              range: range,
            ),
          ),
        );
      },
      child: RecordRowComponent(record: record, showChevron: true),
    );
  }
}
