package com.sherpout.server.error.exception;

import com.sherpout.server.error.model.ApiError;
import com.sherpout.server.error.model.ErrorMessage;
import org.springframework.http.HttpStatus;

public class TooManyRequestException extends SingleApiErrorException {
    public TooManyRequestException() {
        super(ApiError.builder(ErrorMessage.TOO_MANY_REQUESTS, HttpStatus.TOO_MANY_REQUESTS));
    }
}
