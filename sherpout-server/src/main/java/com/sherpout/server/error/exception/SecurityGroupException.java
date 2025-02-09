package com.sherpout.server.error.exception;

import com.sherpout.server.error.model.ErrorLocationType;
import com.sherpout.server.error.model.ErrorMessage;
import lombok.Getter;

@Getter
public class SecurityGroupException extends SingleApiErrorException {

    public SecurityGroupException(ErrorMessage errorMessage, ErrorLocationType errorLocationType) {
        super(errorMessage,errorLocationType);
    }
}
