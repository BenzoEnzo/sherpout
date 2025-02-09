package com.sherpout.server.error.exception;

import com.sherpout.server.error.model.ErrorLocationType;
import com.sherpout.server.error.model.ErrorMessage;
import lombok.AllArgsConstructor;
import lombok.Getter;

import java.util.List;

@Getter
@AllArgsConstructor
public class MultipleApiErrorsException extends RuntimeException{
    private final List<ErrorMessage> errorMessages;
    private final List<ErrorLocationType> errorLocationTypes;
}
