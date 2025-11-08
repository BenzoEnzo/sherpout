package com.sherpout.server.commons.validation;

import com.sherpout.server.commons.validation.validator.LimitValidator;
import com.sherpout.server.commons.validation.validator.MaxFileSizeValidator;
import com.sherpout.server.error.model.ApiError;
import com.sherpout.server.error.model.ErrorMessage;
import jakarta.validation.Constraint;
import jakarta.validation.Payload;
import org.springframework.http.HttpStatus;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

@Constraint(validatedBy = LimitValidator.class)
@Target({ElementType.FIELD, ElementType.PARAMETER})
@Retention(RetentionPolicy.RUNTIME)
public @interface Limit {
    String message() default "";
    Class<?>[] groups() default {};

    Class<? extends Payload>[] payload() default {};

    double value();
}
