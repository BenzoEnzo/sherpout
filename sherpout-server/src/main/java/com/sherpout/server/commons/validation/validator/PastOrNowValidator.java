package com.sherpout.server.commons.validation.validator;

import com.sherpout.server.commons.validation.PastOrNow;
import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;

import java.time.Instant;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.temporal.Temporal;

public class PastOrNowValidator implements ConstraintValidator<PastOrNow, Temporal> {
    @Override
    public boolean isValid(Temporal temporal, ConstraintValidatorContext context) {
        return switch (temporal) {
            case null -> true;
            case LocalDateTime localDateTime -> validateLocalDateTime(localDateTime);
            case LocalDate localDate -> validateLocalDate(localDate);
            case Instant instant -> validateInstant(instant);
            default -> false;
        };
    }

    private boolean validateLocalDateTime(LocalDateTime localDateTime) {
        LocalDateTime now = LocalDateTime.now();
        return localDateTime.isBefore(now) || localDateTime.equals(now);
    }

    private boolean validateLocalDate(LocalDate localDate) {
        LocalDate now = LocalDate.now();
        return localDate.isBefore(now) || localDate.equals(now);
    }

    private boolean validateInstant(Instant instant) {
        Instant now = Instant.now();
        return instant.isBefore(now) || instant.equals(now);
    }
}
