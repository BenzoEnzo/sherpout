package com.sherpout.server.error.exception;

import com.sherpout.server.error.model.ApiError;
import com.sherpout.server.error.model.ErrorLocationType;
import com.sherpout.server.error.model.ErrorMessage;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class SingleApiErrorException extends RuntimeException {
    private final ApiError apiError;
}
