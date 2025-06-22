import 'package:dio/dio.dart';

import '../common/api/api_client.dart';
import '../common/dto/image_url_dto.dart';

class ImageService {
  final ApiClient _apiClient;

  ImageService(this._apiClient);

  Future<ImageUrlDto> fetchImageUrl(String name) async {
    final Response response = await _apiClient.get(
      'images/url',
      queryParameters: {'name': name},
    );
    return ImageUrlDto.fromJson(response.data);
  }
}