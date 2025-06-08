package com.sherpout.server.error.exception;

import com.sherpout.server.error.model.ApiError;
import com.sherpout.server.error.model.ErrorLocationType;
import com.sherpout.server.error.model.ErrorMessage;
import org.springframework.http.HttpStatus;

public class FileException extends SingleApiErrorException {
    public FileException(ErrorMessage errorMessage) {
        super(ApiError.builder(errorMessage, HttpStatus.INTERNAL_SERVER_ERROR)
                .withErrorLocationType(ErrorLocationType.FILE)
        );
    }

    public FileException(ErrorMessage errorMessage, String name) {
        super(ApiError.builder(errorMessage, HttpStatus.INTERNAL_SERVER_ERROR)
                .withErrorLocationType(ErrorLocationType.FILE)
                .withTextParam("name", name)
        );
    }
}