package com.sherpout.server.error.exception;

import com.sherpout.server.error.model.ApiError;
import lombok.AllArgsConstructor;
import lombok.Getter;

import java.util.List;

@Getter
@AllArgsConstructor
public class MultipleApiErrorsException extends RuntimeException {
    private final List<ApiError> apiErrorsList;
}
