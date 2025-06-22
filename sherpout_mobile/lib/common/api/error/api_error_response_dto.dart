import 'package:sherpoutmobile/common/api/error/api_error.dart';

class ApiErrorResponseDto {
  final List<ApiError> apiErrorList;

  ApiErrorResponseDto({
    required this.apiErrorList,
  });

  factory ApiErrorResponseDto.fromJson(Map<String, dynamic> json) {
    final rawList = json['apiErrorList'] as List?;

    return ApiErrorResponseDto(
      apiErrorList: rawList != null
          ? rawList
              .map((e) => ApiError.fromJson(e))
              .whereType<ApiError>()
              .toList()
          : [],
    );
  }
}
