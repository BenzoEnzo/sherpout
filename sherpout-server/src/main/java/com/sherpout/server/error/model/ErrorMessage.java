package com.sherpout.server.error.model;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum ErrorMessage {
    UNAUTHORIZED(
            "Unauthorized access",
            "Nieautoryzowany dostęp"),
    ACCESS_FORBIDDEN(
            "Access Forbidden",
            "Dostęp zabroniony"),
    INTERNAL_ERROR(
            "Internal server error",
            "Błąd serwera"),

    EXERCISE_UNABLE_TO_FIND_BY_ID(
            "Unable to find exercise with id: {{id}}",
            "Nie można znaleźć ćwiczenia o identyfikatorze: {{id}}"),

    RECORD_UNABLE_TO_FIND_BY_ID(
            "Unable to find record with id: {{id}}",
            "Nie można znaleźć rekordu o identyfikatorze: {{id}}");

    private final String english;
    private final String polish;
}
