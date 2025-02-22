package com.sherpout.server.error.handler;

import com.sherpout.server.error.exception.SecurityByGroupException;
import com.sherpout.server.error.exception.SingleApiErrorException;
import com.sherpout.server.error.model.ApiError;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;

@ControllerAdvice
public class SingleApiErrorExceptionHandler {

    @ExceptionHandler(SingleApiErrorException.class)
    @ResponseBody
    public ResponseEntity<ApiError> handleSingleApiErrorException(ApiError apiError) {
        return new ResponseEntity<>(apiError, HttpStatus.INTERNAL_SERVER_ERROR);
    }

    @ExceptionHandler(SecurityByGroupException.class)
    @ResponseBody
    public ResponseEntity<ApiError> handleSecurityGroupException(ApiError apiError) {
        return new ResponseEntity<>(apiError, HttpStatus.UNAUTHORIZED);
    }
}
