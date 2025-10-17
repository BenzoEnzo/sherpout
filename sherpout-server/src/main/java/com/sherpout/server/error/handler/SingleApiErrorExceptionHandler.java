package com.sherpout.server.error.handler;

import com.sherpout.server.error.exception.SecuredByGroupException;
import com.sherpout.server.error.exception.SingleApiErrorException;
import com.sherpout.server.error.model.ApiErrorResponseDTO;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;

@ControllerAdvice
public class SingleApiErrorExceptionHandler {

    @ExceptionHandler(SingleApiErrorException.class)
    @ResponseBody
    public ResponseEntity<ApiErrorResponseDTO> handleSingleApiErrorException(SingleApiErrorException ex) {
        return ResponseEntity
                .status(ex.getApiError().getHttpStatus())
                .body(new ApiErrorResponseDTO(ex.getApiError()));
    }

    @ExceptionHandler(SecuredByGroupException.class)
    @ResponseBody
    public ResponseEntity<ApiErrorResponseDTO> handleSecurityGroupException(SecuredByGroupException ex) {
        return ResponseEntity
                .status(ex.getApiError().getHttpStatus())
                .body(new ApiErrorResponseDTO(ex.getApiError()));
    }
}
