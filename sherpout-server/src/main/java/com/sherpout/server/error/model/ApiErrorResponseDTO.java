package com.sherpout.server.error.model;

import lombok.AllArgsConstructor;
import lombok.Getter;

import java.time.LocalDateTime;
import java.util.List;

@Getter
@AllArgsConstructor
public class ApiErrorResponseDTO {
    private final LocalDateTime errorOccurredAt = LocalDateTime.now();
    private final List<ApiError> apiErrorList;

    public ApiErrorResponseDTO(ApiError apiError) {
        this.apiErrorList = List.of(apiError);
    }
}
