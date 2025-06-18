package com.sherpout.server.error.handler;

import com.sherpout.server.error.exception.MultipleApiErrorsException;
import com.sherpout.server.error.model.ApiErrorResponseDTO;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;

@ControllerAdvice
public class MultipleApiErrorExceptionHandler {

    @ExceptionHandler(MultipleApiErrorsException.class)
    @ResponseBody
    public ResponseEntity<ApiErrorResponseDTO> handleMultipleApiErrorsException(MultipleApiErrorsException ex) {
        return ResponseEntity
                .status(ex.getApiErrorsList().getFirst().getHttpStatus())
                .body(new ApiErrorResponseDTO(ex.getApiErrorsList()));
    }
}
