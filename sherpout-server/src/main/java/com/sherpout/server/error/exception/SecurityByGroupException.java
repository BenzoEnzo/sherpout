package com.sherpout.server.error.exception;

import com.sherpout.server.error.model.ApiError;
import com.sherpout.server.error.model.ErrorLocationType;
import com.sherpout.server.error.model.ErrorMessage;
import lombok.Getter;

@Getter
public class SecurityByGroupException extends SingleApiErrorException {

    public SecurityByGroupException(ApiError apiError) {
        super(apiError);
    }
}
