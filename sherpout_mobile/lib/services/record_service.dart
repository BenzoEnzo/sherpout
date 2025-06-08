import 'package:dio/dio.dart';
import '../common/api_client.dart';
import '../common/dto/record_dto.dart';

class RecordService {
  final ApiClient _apiClient;

  RecordService(this._apiClient);

  Future<List<RecordDTO>> getRecords() async {
    Response<dynamic> response = await _apiClient.get('records');
    final List<dynamic> data = response.data;
    return data.map((json) => RecordDTO.fromJson(json)).toList();
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
}
