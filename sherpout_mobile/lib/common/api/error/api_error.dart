import '../../dto/translated_string_dto.dart';
import 'error_location_type.dart';

class ApiError {
  final TranslatedStringDto translatedErrorMessage;
  final String errorMessage;
  final ErrorLocationType? errorLocationType;
  final String? location;

  ApiError({
    required this.translatedErrorMessage,
    required this.errorMessage,
    this.errorLocationType,
    this.location,
  });

  factory ApiError.fromJson(Map<String, dynamic> json) {
    return ApiError(
        translatedErrorMessage:
            TranslatedStringDto.fromJson(json['translatedErrorMessage']),
        errorMessage: json['errorMessage'] as String,
        errorLocationType: json['errorLocationType'] != null
            ? ErrorLocationType.fromName(json['errorLocationType'])
            : null,
        location: json['location']);
  }
}
