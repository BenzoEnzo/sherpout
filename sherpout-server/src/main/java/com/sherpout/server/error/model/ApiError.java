package com.sherpout.server.error.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.sherpout.server.commons.dto.TranslatedStringDTO;
import lombok.*;
import org.springframework.http.HttpStatus;

import java.util.HashMap;
import java.util.Map;

@Getter
public class ApiError {
    private final TranslatedStringDTO translatedErrorMessage;
    private final ErrorLocationType errorLocationType;
    private final ErrorMessage errorMessage;
    private final String location;
    @JsonIgnore
    private final HttpStatus httpStatus;

    private ApiError(Builder builder) {
        this.translatedErrorMessage = builder.translatedString;
        this.errorLocationType = builder.errorLocationType;
        this.errorMessage = builder.errorMessage;
        this.location = builder.location;
        this.httpStatus = builder.httpStatus;
    }

    public static ApiError.Builder builder(ErrorMessage errorMessage, HttpStatus httpStatus){
        return new ApiError.Builder(errorMessage, httpStatus);
    }

    public static class Builder {
        private final ErrorMessage errorMessage;
        private ErrorLocationType errorLocationType;
        private final HttpStatus httpStatus;
        private String location;
        private final Map<String, Object> textParams = new HashMap<>();
        private TranslatedStringDTO translatedString;

        public Builder(ErrorMessage errorMessage, HttpStatus httpStatus) {
            this.errorMessage = errorMessage;
            this.httpStatus = httpStatus;
        }

        public Builder withErrorLocationType(ErrorLocationType errorLocationType) {
            this.errorLocationType = errorLocationType;
            return this;
        }

        public Builder withLocation(String location) {
            this.location = location;
            return this;
        }

        public Builder withTextParam(String key, Object value) {
            this.textParams.put(key, value);
            return this;
        }

        public ApiError build() {
            translatedString = new TranslatedStringDTO();

            if (errorMessage != null) {
                translatedString.setEn(fillPlaceholders(errorMessage.getEnglish(), textParams));
                translatedString.setPl(fillPlaceholders(errorMessage.getPolish(), textParams));
            }
            return new ApiError(this);
        }

        private String fillPlaceholders(String message, Map<String, Object> placeholders) {
            if (placeholders == null) {
                return message;
            }
            String result = message;

            for (Map.Entry<String, Object> entry : placeholders.entrySet()) {
                String placeholder = "{{" + entry.getKey() + "}}";
                result = result.replace(placeholder, String.valueOf(entry.getValue()));
            }

            return result;
        }
    }
}
