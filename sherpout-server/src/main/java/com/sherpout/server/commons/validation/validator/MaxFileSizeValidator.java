package com.sherpout.server.commons.validation.validator;

import com.sherpout.server.commons.validation.MaxFileSize;
import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;

public class MaxFileSizeValidator implements ConstraintValidator<MaxFileSize, byte[]> {
    private int maxSizeInBytes;

    @Override
    public void initialize(MaxFileSize constraintAnnotation) {
        this.maxSizeInBytes = constraintAnnotation.value() * 1024 * 1024;
    }

    @Override
    public boolean isValid(byte[] imageData, ConstraintValidatorContext context) {
        if (imageData == null) {
            return true;
        }
        return imageData.length <= maxSizeInBytes;
    }
}
