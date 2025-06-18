package com.sherpout.server.error.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import org.springframework.http.HttpStatus;

import java.time.LocalDateTime;
import java.util.List;

@Getter
@AllArgsConstructor
public class ApiErrorResponseDTO {
    private final LocalDateTime errorOccurredAt = LocalDateTime.now();
    private final List<ApiError> apiErrorList;
}
