package com.sherpout.server.error.handler;

import com.sherpout.server.error.exception.MultipleApiErrorsException;
import com.sherpout.server.error.model.ApiError;
import com.sherpout.server.error.model.ErrorLocationType;
import com.sherpout.server.error.model.ErrorMessage;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Collections;

@ControllerAdvice
public class MultipleApiErrorExceptionHandler {

    @ExceptionHandler(MultipleApiErrorsException.class)
    @ResponseBody
    public ResponseEntity<ApiError> handleMultipleApiErrorsException() {
        ApiError apiError = ApiError.builder()
                .errorMessages(Collections.singletonList(ErrorMessage.INTERNAL_ERROR))
                .errorLocationType(ErrorLocationType.BODY)
                .build();

        return new ResponseEntity<>(apiError, HttpStatus.INTERNAL_SERVER_ERROR);
    }
}
