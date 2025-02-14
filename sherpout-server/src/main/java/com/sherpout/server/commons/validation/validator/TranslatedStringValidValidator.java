package com.sherpout.server.commons.validation.validator;

import com.sherpout.server.commons.dto.TranslatedStringDTO;
import com.sherpout.server.commons.validation.TranslatedStringValid;
import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;

public class TranslatedStringValidValidator  implements ConstraintValidator<TranslatedStringValid, TranslatedStringDTO> {
    @Override
    public boolean isValid(TranslatedStringDTO translatedString, ConstraintValidatorContext context) {
        if (translatedString == null) {
            return true;
        }

        boolean isEnglishSet = translatedString.getEn() != null && !translatedString.getEn().isEmpty();
        boolean isPolishSet = translatedString.getPl() != null && !translatedString.getPl().isEmpty();

        return isEnglishSet || isPolishSet;
    }
}
