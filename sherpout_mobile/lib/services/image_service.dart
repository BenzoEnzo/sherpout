import 'package:dio/dio.dart';
import '../common/api_client.dart';
import 'package:sherpoutmobile/common/dto/image_dto.dart';

class ImageService {
  final ApiClient _apiClient;

  ImageService(this._apiClient);

  Future<ImageDto> fetchImage(String objectName) async {
    final Response response = await _apiClient.get(
      'images/url',
      queryParameters: {'objectName': objectName},
    );
    return ImageDto.fromJson(response.data as Map<String, dynamic>);
  }
}