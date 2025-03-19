package com.sherpout.server.error.exception;

import com.sherpout.server.error.model.ApiError;
import com.sherpout.server.error.model.ErrorMessage;
import lombok.Getter;
import org.springframework.http.HttpStatus;

@Getter
public class SecuredByGroupException extends SingleApiErrorException {
    private final static ApiError.Builder apiError = ApiError
            .builder(ErrorMessage.UNAUTHORIZED, HttpStatus.UNAUTHORIZED);

    public SecuredByGroupException() {
        super(apiError);
    }
}
