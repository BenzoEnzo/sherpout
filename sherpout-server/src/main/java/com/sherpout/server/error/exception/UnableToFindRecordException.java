package com.sherpout.server.error.exception;

import com.sherpout.server.error.model.ApiError;
import com.sherpout.server.error.model.ErrorLocationType;
import com.sherpout.server.error.model.ErrorMessage;
import org.springframework.http.HttpStatus;

public class UnableToFindRecordException extends SingleApiErrorException {
    public UnableToFindRecordException(ErrorLocationType locationType, Long id) {
        super(ApiError.builder(ErrorMessage.RECORD_UNABLE_TO_FIND_BY_ID, HttpStatus.NOT_FOUND)
                .withErrorLocationType(locationType)
                .withLocation("id")
                .withTextParam("id", id)
        );
    }
}
