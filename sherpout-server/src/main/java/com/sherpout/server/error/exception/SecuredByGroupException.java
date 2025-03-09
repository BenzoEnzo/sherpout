package com.sherpout.server.error.exception;

import com.sherpout.server.error.model.ApiError;
import com.sherpout.server.error.model.ErrorLocationType;
import com.sherpout.server.error.model.ErrorMessage;
import lombok.Getter;
import org.springframework.http.HttpStatus;

@Getter
public class SecuredByGroupException extends SingleApiErrorException {

    public SecuredByGroupException() {
        super(new ApiError.Builder(ErrorMessage.UNAUTHORIZED, HttpStatus.UNAUTHORIZED)
                .withErrorLocationType(ErrorLocationType.HEADER_PARAM));
    }
}
