package com.sherpout.server.error.handler;

import com.sherpout.server.error.exception.SecuredByGroupException;
import com.sherpout.server.error.exception.SingleApiErrorException;
import com.sherpout.server.error.model.ApiError;
import com.sherpout.server.error.model.ApiErrorResponseDTO;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Collections;

@ControllerAdvice
public class SingleApiErrorExceptionHandler {

    @ExceptionHandler(SingleApiErrorException.class)
    @ResponseBody
    public ResponseEntity<ApiErrorResponseDTO> handleSingleApiErrorException(SingleApiErrorException ex) {
        return new ResponseEntity<>(ApiErrorResponseDTO.builder()
                .apiErrorList(Collections.singletonList(ex.getApiError()))
                .httpStatus(ex.getApiError().getHttpStatus())
                .build(), ex.getApiError().getHttpStatus());
    }

    @ExceptionHandler(SecuredByGroupException.class)
    @ResponseBody
    public ResponseEntity<ApiErrorResponseDTO> handleSecurityGroupException(SecuredByGroupException ex) {
        return new ResponseEntity<>(ApiErrorResponseDTO.builder()
                .apiErrorList(Collections.singletonList(ex.getApiError()))
                .httpStatus(ex.getApiError().getHttpStatus())
                .build(), ex.getApiError().getHttpStatus());
    }
}
