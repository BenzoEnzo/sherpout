import 'package:dio/dio.dart';
import 'package:sherpoutmobile/common/dto/exercise_dto.dart';
import 'package:sherpoutmobile/common/dto/exercise_list_dto.dart';
import 'package:sherpoutmobile/common/dto/exercise_select_dto.dart';

import '../common/api_client.dart';

class ExerciseService {
  final ApiClient _apiClient;

  ExerciseService(this._apiClient);

  Future<List<ExerciseListDto>> getAll() async {
    Response<dynamic> response = await _apiClient.get('exercises');
    final List<dynamic> data = response.data;
    return data.map((json) => ExerciseListDto.fromJson(json)).toList();
  }

  Future<ExerciseDto> getById(int id) async {
    Response<dynamic> response = await _apiClient.get('exercises/$id');
    return ExerciseDto.fromJson(response.data);
  }

  Future<List<ExerciseSelectDTO>> getSelects() async {
    Response<dynamic> response = await _apiClient.get('exercises/select');
    final List<dynamic> data = response.data;
    return data.map((json) => ExerciseSelectDTO.fromJson(json)).toList();
  }
}
