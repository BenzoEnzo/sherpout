package com.sherpout.server.error.exception;

import com.sherpout.server.error.model.ApiError;
import com.sherpout.server.error.model.ErrorLocationType;
import com.sherpout.server.error.model.ErrorMessage;
import lombok.Getter;
import org.springframework.http.HttpStatus;

@Getter
public class SecuredByGroupException extends SingleApiErrorException {
    private final ApiError apiError;

    public SecuredByGroupException(ApiError.Builder builder) {
        super(builder);

        apiError = builder
                .withErrorMessage(ErrorMessage.UNAUTHORIZED)
                .withErrorLocationType(ErrorLocationType.HEADER_PARAM)
                .withHttpStatus(HttpStatus.UNAUTHORIZED)
                .build();
    }
}
