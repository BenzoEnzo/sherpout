import 'package:flutter/material.dart';

import 'api_error.dart';
import 'error_location_type.dart';

class ApiErrorHandler {
  final List<ApiError> errors;

  ApiErrorHandler(this.errors);

  Map<String, List<String>> getFormBackendErrors(BuildContext context) {
    var bodyErrors = errors
        .where((e) => e.errorLocationType == ErrorLocationType.body)
        .toList();

    final Map<String, List<String>> formBackendErrors = {};

    for (final error in bodyErrors) {
      final location = error.location;
      if (location == null) continue;

      formBackendErrors.update(
        location,
        (list) => [...list, error.translatedErrorMessage.localized(context)],
        ifAbsent: () => [error.translatedErrorMessage.localized(context)],
      );
    }

    return formBackendErrors;
  }

  List<ApiError> forLocation(String location) {
    return errors.where((e) => e.location == location).toList();
  }

  void showRemainingErrors(
      BuildContext context, List<ErrorLocationType> handledTypes) {
    final remainingErrors = errors
        .where((e) => !handledTypes.contains(e.errorLocationType))
        .toList();
    _showErrors(context, remainingErrors);
  }

  void showAllErrors(BuildContext context) {
    _showErrors(context, errors);
  }

  void _showErrors(BuildContext context, List<ApiError> errors) {
    for (var error in errors) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(error.translatedErrorMessage.localized(context))),
      );
    }
  }
}
