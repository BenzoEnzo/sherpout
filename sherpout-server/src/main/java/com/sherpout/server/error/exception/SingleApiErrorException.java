package com.sherpout.server.error.exception;

import com.sherpout.server.error.model.ApiError;
import com.sherpout.server.error.model.ErrorLocationType;
import com.sherpout.server.error.model.ErrorMessage;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
public class SingleApiErrorException extends RuntimeException {
    private final ApiError apiError;

    public SingleApiErrorException(ApiError.Builder builder) {
        apiError = builder.build();
    }
}
