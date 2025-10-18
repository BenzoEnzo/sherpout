import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:sherpoutmobile/common/components/app_page.dart';
import 'package:sherpoutmobile/common/components/buttons/app_text_and_icon_button.dart';
import 'package:sherpoutmobile/common/components/loading_component.dart';
import 'package:sherpoutmobile/common/dto/record_dto.dart';
import 'package:sherpoutmobile/pages/records/create/record_create_dialog.dart';
import 'package:sherpoutmobile/pages/records/list/record_list_item.dart';
import 'package:sherpoutmobile/services/record_service.dart';

class RecordsPage extends StatefulWidget {
  const RecordsPage({super.key});

  @override
  State<RecordsPage> createState() => _RecordsPageState();
}

class _RecordsPageState extends State<RecordsPage> {
  final RecordService _recordService = GetIt.instance<RecordService>();

  List<RecordDTO> _records = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadRecords();
  }

  Future<void> _loadRecords() async {
    try {
      final records = await _recordService.getRecords();
      setState(() {
        _records = records;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Błąd ładowania rekordów: $e';
        _isLoading = false;
      });
    }
  }

  Future<void> _onAddNew() async {
    final created = await showDialog<bool>(
      context: context,
      builder: (_) => RecordCreateDialog(),
    );
    if (created == true) _loadRecords();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.records),
      ),
      body: LoadingComponent(
          isLoading: _isLoading,
          error: _error,
          child: AppPage(
              child: ListView.builder(
            itemCount: _records.length,
            itemBuilder: (context, index) {
              return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: RecordItem(record: _records[index]));
            },
          ))),
      floatingActionButton: AppTextAndIconButton(
          text: AppLocalizations.of(context)!.addNew,
          icon: Icons.add,
          onPressed: () => _onAddNew()
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
