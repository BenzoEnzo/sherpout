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
import java.util.Objects;
import java.util.function.Function;

@ControllerAdvice
public class ValidationExceptionHandler {
    private final Map<String, Function<FieldError, ApiError.Builder>> errorHandlers = Map.of(
            "Null", this::getNullError,
            "NotNull", this::getNotNullError,
            "Min", this::getMinError,
            "Max", this::getMaxError
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
        return errorHandlers
                .getOrDefault(
                        getValidationName(apiError.getCodes()),
                        fe -> ApiError.builder(ErrorMessage.INTERNAL_ERROR, HttpStatus.INTERNAL_SERVER_ERROR)
                )
                .apply(apiError)
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

    private ApiError.Builder getNullError(FieldError error) {
        return ApiError.builder(ErrorMessage.ACCESS_FORBIDDEN, HttpStatus.BAD_REQUEST);
    }

    private ApiError.Builder getNotNullError(FieldError error) {
        return ApiError.builder(ErrorMessage.ACCESS_FORBIDDEN, HttpStatus.BAD_REQUEST);
    }

    private ApiError.Builder getMinError(FieldError error) {
        return ApiError.builder(ErrorMessage.ACCESS_FORBIDDEN, HttpStatus.BAD_REQUEST)
                .withTextParam("min", Objects.requireNonNull(error.getArguments())[1]);
    }

    private ApiError.Builder getMaxError(FieldError error) {
        return ApiError.builder(ErrorMessage.ACCESS_FORBIDDEN, HttpStatus.BAD_REQUEST)
                .withTextParam("max", Objects.requireNonNull(error.getArguments())[1]);
    }
}
