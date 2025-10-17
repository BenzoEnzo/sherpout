package com.sherpout.server.commons.validation.validator;

import com.sherpout.server.commons.validation.Limit;
import com.sherpout.server.error.exception.LimitException;
import com.sherpout.server.error.model.ErrorMessage;
import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;

public class LimitValidator implements ConstraintValidator<Limit, Double> {
    private Double maxValue;

    @Override
    public void initialize(Limit constraintAnnotation) {
        this.maxValue = constraintAnnotation.value();
    }

    @Override
    public boolean isValid(Double value, ConstraintValidatorContext context) {
        if(value <= maxValue){
            return true;
        }
        throw new LimitException(ErrorMessage.VALIDATION_LIMIT, maxValue);
    }
}
