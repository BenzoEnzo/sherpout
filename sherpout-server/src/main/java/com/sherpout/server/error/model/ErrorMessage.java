package com.sherpout.server.error.model;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum ErrorMessage {
    UNAUTHORIZED(
            "Unauthorized access.",
            "Nieautoryzowany dostęp."),
    ACCESS_FORBIDDEN(
            "Access Forbidden.",
            "Dostęp zabroniony."),
    INTERNAL_ERROR(
            "Internal server error occured.",
            "Wystąpił błąd serwera."),

    VALIDATION_NULL(
            "This field has to be empty.",
            "To pole musi być puste."),

    VALIDATION_NOT_NULL(
            "This field cannot be empty.",
            "To pole nie może być puste."),

    VALIDATION_MIN(
            "This value is too small.",
            "Ta wartość jest zbyt mała."),

    VALIDATION_MAX(
            "This value is too big.",
            "Ta wartość jest zbyt duża."),

    VALIDATION_MAX_FILE_SIZE(
            "The uploaded file is too large.",
            "Przesłany plik jest za duży."),

    VALIDATION_PAST_OR_NOW(
            "The date must be in the past or today.",
            "Data musi być z przeszłości lub z dzisiaj."),

    VALIDATION_TRANSLATED_STRING_VALID(
            "This text must have at least one translation.",
            "Ten tekst musi mieć przynajmniej jedną translację."),

    FILE_STORAGE_ERROR(
            "An error occurred while saving the file.",
            "Wystąpił błąd podczas zapisywania pliku."),
    IMAGE_FETCH_ERROR(
            "Unable to fetch image from bucket with name: {{name}}.",
            "Nie można pobrać zdjęcia z bucketu o nazwie: {{name}}."),
    IMAGE_DELETE_ERROR(
            "Unable to delete image from bucket with name: {{name}}",
            "Nie można usunąć zdjęcia z bucketu o nazwie: {{name}}"),
    COVER_IMAGE_ERROR(
            "Unable to load cover image for exercise: {{name}}",
            "Nie można załadować okładki dla ćwiczenia: {{name}}"),

    EXERCISE_UNABLE_TO_FIND_BY_ID(
            "Unable to find exercise with id: {{id}}.",
            "Nie można znaleźć ćwiczenia o identyfikatorze: {{id}}."),

    RECORD_UNABLE_TO_FIND_BY_ID(
            "Unable to find record with id: {{id}}.",
            "Nie można znaleźć rekordu o identyfikatorze: {{id}}."),

    TRAINING_PLAN_UNABLE_TO_FIND_BY_ID(
            "Unable to find training plan with id: {{id}}.",
            "Nie można znaleźć planu treningowego o identyfikatorze: {{id}}.");

    private final String english;
    private final String polish;
}
