package com.sherpout.server.error.exception;

import com.sherpout.server.error.model.ApiError;
import com.sherpout.server.error.model.ErrorMessage;
import org.springframework.http.HttpStatus;

public class AccessForbiddenException extends SingleApiErrorException {
    private final static ApiError.Builder apiError = ApiError
            .builder(ErrorMessage.ACCESS_FORBIDDEN, HttpStatus.FORBIDDEN);
    public AccessForbiddenException() {
        super(apiError);
    }
}
