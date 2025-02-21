package com.sherpout.server.error.handler;

import com.sherpout.server.error.exception.MultipleApiErrorsException;
import com.sherpout.server.error.model.ApiError;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@ControllerAdvice
public class MultipleApiErrorExceptionHandler {

    @ExceptionHandler(MultipleApiErrorsException.class)
    @ResponseBody
    public ResponseEntity<List<ApiError>> handleMultipleApiErrorsException(List<ApiError> apiErrors) {
        return new ResponseEntity<>(apiErrors, HttpStatus.INTERNAL_SERVER_ERROR);
    }
}
