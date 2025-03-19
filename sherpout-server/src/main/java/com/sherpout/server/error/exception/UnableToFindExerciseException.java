package com.sherpout.server.error.exception;

import com.sherpout.server.error.model.ApiError;
import com.sherpout.server.error.model.ErrorLocationType;
import com.sherpout.server.error.model.ErrorMessage;
import org.springframework.http.HttpStatus;

public class UnableToFindExerciseException extends SingleApiErrorException {
    public UnableToFindExerciseException(ErrorLocationType locationType, String location, Long id) {
        super(ApiError.builder(ErrorMessage.EXERCISE_UNABLE_TO_FIND_BY_ID, HttpStatus.NOT_FOUND)
                        .withErrorLocationType(locationType)
                        .withLocation(location)
                        .withTextParam("id", id)
        );
    }
}
