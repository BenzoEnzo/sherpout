package com.sherpout.server.error.model;

import lombok.*;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

@Getter
@Builder
@AllArgsConstructor(access = AccessLevel.PRIVATE)
public class ApiError {
    private ErrorMessage errorMessage;
    private ErrorLocationType errorLocationType;
    private String location;
    private Map<String, String> additionalParams;
    private Map<String, String> textParams;
    private final LocalDateTime errorOccurredAt = LocalDateTime.now();
}
