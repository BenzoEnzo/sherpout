package com.sherpout.server.api.exercise.dto;

import com.sherpout.server.commons.dto.TranslatedStringDTO;
import com.sherpout.server.commons.validation.TranslatedStringValid;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Null;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class RecordExerciseDTO {
    @Null
    private Long id;

    @NotNull
    @TranslatedStringValid
    private TranslatedStringDTO name;
}
