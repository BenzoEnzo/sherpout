package com.sherpout.server.error.handler;

import com.sherpout.server.error.model.ApiError;
import com.sherpout.server.error.model.ApiErrorResponseDTO;
import com.sherpout.server.error.model.ErrorLocationType;
import com.sherpout.server.error.model.ErrorMessage;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;
import java.util.Map;

@ControllerAdvice
public class ValidationExceptionHandler {
    private static final Map<String, ErrorMessage> errorMessageMap = Map.of(
            "Null", ErrorMessage.VALIDATION_NULL,
            "NotNull", ErrorMessage.VALIDATION_NOT_NULL,
            "Min", ErrorMessage.VALIDATION_MIN,
            "Max", ErrorMessage.VALIDATION_MAX,
            "MaxFileSize", ErrorMessage.VALIDATION_MAX_FILE_SIZE,
            "PastOrNow", ErrorMessage.VALIDATION_PAST_OR_NOW,
            "TranslatedStringValid", ErrorMessage.VALIDATION_TRANSLATED_STRING_VALID
    );

    @ExceptionHandler(MethodArgumentNotValidException.class)
    @ResponseBody
    public ResponseEntity<ApiErrorResponseDTO> handleValidationError(MethodArgumentNotValidException ex) {
        List<ApiError> apiErrors = ex.getBindingResult().getFieldErrors().stream()
                .map(this::getApiError)
                .toList();

        return ResponseEntity
                .status(apiErrors.getFirst().getHttpStatus())
                .body(new ApiErrorResponseDTO(apiErrors));
    }

    private ApiError getApiError(FieldError apiError) {
        ErrorMessage errorMessage = errorMessageMap.getOrDefault(
                getValidationName(apiError.getCodes()),
                ErrorMessage.INTERNAL_ERROR
        );

        return ApiError.builder(errorMessage, HttpStatus.UNPROCESSABLE_ENTITY)
                .withErrorLocationType(ErrorLocationType.BODY)
                .withLocation(apiError.getField().replace(".", "/"))
                .build();
    }

    private String getValidationName(String[] codes) {
        if (codes == null || codes.length < 4) {
            throw new IllegalArgumentException();
        }
        return codes[3];
    }
}
