import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:sherpoutmobile/common/dto/date_range_query_param.dart';

import '../common/api/api_client.dart';
import '../common/dto/record_dto.dart';
import '../common/dto/record_history_dto.dart';

class RecordService {
  final ApiClient _apiClient;

  RecordService(this._apiClient);

  Future<List<RecordDTO>> getRecords() async {
    Response<dynamic> response = await _apiClient.get('records');
    final List<dynamic> data = response.data;
    return data.map((json) => RecordDTO.fromJson(json)).toList();
  }

  Future<List<RecordHistoryDTO>> getRecordHistory(int exerciseId, DateRangeQueryParam dateRangeQueryParam) async {
    Response<dynamic> response = await _apiClient.get('records/history/$exerciseId', queryParameters: dateRangeQueryParam.asQueryParameters());
    final List<dynamic> data = response.data;
    return data.map((json) => RecordHistoryDTO.fromJson(json)).toList();
  }

  Future<RecordDTO> create(RecordDTO record) async {
    Response<dynamic> response = await _apiClient.post('records', data: record.toJson());
    final dynamic data = response.data;
    return RecordDTO.fromJson(data);
  }

  Future<RecordDTO> update(RecordDTO record) async {
    Response<dynamic> response = await _apiClient.put('records/${record.id}', data: record.toJson());
    final dynamic data = response.data;
    return RecordDTO.fromJson(data);
  }

  Future<void> delete(int id) async {
    await _apiClient.delete('records/$id');
  }
}
