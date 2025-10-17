package com.sherpout.server.error.exception;

import com.sherpout.server.error.model.ApiError;
import com.sherpout.server.error.model.ErrorLocationType;
import com.sherpout.server.error.model.ErrorMessage;
import org.springframework.http.HttpStatus;

public class LimitException extends SingleApiErrorException {
    public LimitException(ErrorMessage errorMessage) {
        super(ApiError.builder(errorMessage, HttpStatus.INTERNAL_SERVER_ERROR)
                .withErrorLocationType(ErrorLocationType.BODY)
        );
    }

    public LimitException(ErrorMessage errorMessage, Long amount) {
        super(ApiError.builder(errorMessage, HttpStatus.INTERNAL_SERVER_ERROR)
                .withErrorLocationType(ErrorLocationType.BODY)
                .withTextParam("amount", amount)
        );
    }
}