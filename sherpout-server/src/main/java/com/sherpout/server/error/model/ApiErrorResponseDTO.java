package com.sherpout.server.error.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Builder;
import lombok.Getter;
import org.springframework.http.HttpStatus;

import java.time.LocalDateTime;
import java.util.List;

@Getter
@Builder
public class ApiErrorResponseDTO {
    @JsonIgnore
    private final HttpStatus httpStatus;
    private final LocalDateTime errorOccurredAt = LocalDateTime.now();
    private final List<ApiError> apiErrorList;
}
