package com.sherpout.server.commons.validation;

import com.sherpout.server.commons.validation.validator.MaxFileSizeValidator;
import jakarta.validation.Constraint;
import jakarta.validation.Payload;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

@Constraint(validatedBy = MaxFileSizeValidator.class)
@Target({ElementType.FIELD, ElementType.PARAMETER})
@Retention(RetentionPolicy.RUNTIME)
public @interface MaxFileSize {
    String message() default "File size must not exceed {value} MB";

    Class<?>[] groups() default {};

    Class<? extends Payload>[] payload() default {};

    int value();
}
