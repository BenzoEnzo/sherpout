package com.sherpout.server.error.handler;

import com.sherpout.server.error.exception.MultipleApiErrorsException;
import com.sherpout.server.error.model.ApiError;
import com.sherpout.server.error.model.ApiErrorResponseDTO;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@ControllerAdvice
public class MultipleApiErrorExceptionHandler {

    @ExceptionHandler(MultipleApiErrorsException.class)
    @ResponseBody
    public ResponseEntity<ApiErrorResponseDTO> handleMultipleApiErrorsException(List<ApiError> apiErrors) {
        return new ResponseEntity<>(ApiErrorResponseDTO.builder()
                .apiErrorList(apiErrors)
                .httpStatus(apiErrors.getFirst().getHttpStatus())
                .build(), apiErrors.getFirst().getHttpStatus());
    }
}
