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
    FILE_STORAGE_ERROR(
            "Unable to upload files to the bucket",
            "Nie można dodać plików do bucketu"),
    IMAGE_FETCH_ERROR(
            "Unable to fetch image from bucket with name: {{name}}",
            "Nie można pobrać zdjęcia z bucketu o nazwie: {{name}}"),
    IMAGE_DELETE_ERROR(
            "Unable to delete image from bucket with name: {{name}}",
            "Nie można usunąć zdjęcia z bucketu o nazwie: {{name}}"),
    EXERCISE_UNABLE_TO_FIND_BY_ID(
            "Unable to find exercise with id: {{id}}",
            "Nie można znaleźć ćwiczenia o identyfikatorze: {{id}}"),

    RECORD_UNABLE_TO_FIND_BY_ID(
            "Unable to find record with id: {{id}}",
            "Nie można znaleźć rekordu o identyfikatorze: {{id}}");

    private final String english;
    private final String polish;
}
