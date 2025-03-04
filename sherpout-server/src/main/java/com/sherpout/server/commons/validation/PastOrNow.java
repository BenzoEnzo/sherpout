package com.sherpout.server.commons.validation;

import com.sherpout.server.commons.validation.validator.PastOrNowValidator;
import jakarta.validation.Constraint;
import jakarta.validation.Payload;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

@Constraint(validatedBy = PastOrNowValidator.class)
@Target({ ElementType.FIELD, ElementType.PARAMETER })
@Retention(RetentionPolicy.RUNTIME)
public @interface PastOrNow {
    String message() default "Date must be now or in the past";

    Class<?>[] groups() default {};

    Class<? extends Payload>[] payload() default {};
}
