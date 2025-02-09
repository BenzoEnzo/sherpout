package com.sherpout.server.error.handler;

import com.sherpout.server.error.exception.SecurityGroupException;
import com.sherpout.server.error.exception.SingleApiErrorException;
import com.sherpout.server.error.model.ApiError;
import com.sherpout.server.error.model.ErrorLocationType;
import com.sherpout.server.error.model.ErrorMessage;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@ControllerAdvice
public class SingleApiErrorExceptionHandler {

    @ExceptionHandler(SingleApiErrorException.class)
    @ResponseBody
    public ResponseEntity<ApiError> handleSingleApiErrorException(List<ErrorMessage> errorMessages, ErrorLocationType errorLocationType) {
        ApiError apiError = ApiError.builder()
                .errorMessages(errorMessages)
                .errorLocationType(ErrorLocationType.BODY)
                .build();

        return new ResponseEntity<>(apiError, HttpStatus.INTERNAL_SERVER_ERROR);
    }

    @ExceptionHandler(SecurityGroupException.class)
    @ResponseBody
    public ResponseEntity<ApiError> handleSecurityGroupException(List<ErrorMessage> errorMessages, ErrorLocationType errorLocationType) {
        ApiError apiError = ApiError.builder()
                .errorMessages(errorMessages)
                .errorLocationType(ErrorLocationType.BODY)
                .build();

        return new ResponseEntity<>(apiError, HttpStatus.UNAUTHORIZED);
    }
}
