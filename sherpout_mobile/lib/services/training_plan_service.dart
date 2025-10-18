import 'package:dio/dio.dart';
import 'package:sherpoutmobile/common/dto/training_plan_dto.dart';

import '../common/api/api_client.dart';

class TrainingPlanService {
  final ApiClient _apiClient;

  TrainingPlanService(this._apiClient);

  Future<TrainingPlanDTO> getById(int id) async {
    Response<dynamic> response = await _apiClient.get('training-plans/$id');
    return TrainingPlanDTO.fromJson(response.data);
  }

  Future<TrainingPlanDTO> create(TrainingPlanDTO trainingPlan) async {
    Response<dynamic> response = await _apiClient.post('training-plans', data: trainingPlan.toJson());
    final dynamic data = response.data;
    return TrainingPlanDTO.fromJson(data);
  }

  Future<TrainingPlanDTO> update(TrainingPlanDTO record) async {
    Response<dynamic> response = await _apiClient.put('training-plans/${record.id}', data: record.toJson());
    final dynamic data = response.data;
    return TrainingPlanDTO.fromJson(data);
  }
}