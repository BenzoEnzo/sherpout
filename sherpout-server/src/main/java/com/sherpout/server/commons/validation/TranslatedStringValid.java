package com.sherpout.server.commons.validation;

import com.sherpout.server.commons.validation.validator.TranslatedStringValidValidator;
import jakarta.validation.Constraint;
import jakarta.validation.Payload;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

@Constraint(validatedBy = TranslatedStringValidValidator.class)
@Target({ElementType.FIELD, ElementType.PARAMETER})
@Retention(RetentionPolicy.RUNTIME)
public @interface TranslatedStringValid {
    String message() default "Translated string must have at least one translation";

    Class<?>[] groups() default {};

    Class<? extends Payload>[] payload() default {};
}
