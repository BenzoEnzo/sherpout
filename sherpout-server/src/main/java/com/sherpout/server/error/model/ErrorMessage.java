package com.sherpout.server.error.model;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum ErrorMessage {
    INVALID_INPUT("Invalid input: {{name}}", "Nieprawidłowe dane: {{name}}"),
    UNAUTHORIZED("Unauthorized access", "Nieautoryzowany dostęp"),
    FORBIDDEN("Access Forbidden", "Dostęp zabroniony"),
    INTERNAL_ERROR("Internal server error", "Błąd serwera");

    private final String english;
    private final String polish;
}
