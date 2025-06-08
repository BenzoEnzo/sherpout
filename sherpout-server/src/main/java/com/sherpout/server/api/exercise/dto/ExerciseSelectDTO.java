package com.sherpout.server.api.exercise.dto;

import com.sherpout.server.api.image.dto.ImageDTO;
import com.sherpout.server.commons.dto.TranslatedStringDTO;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ExerciseSelectDTO {
    @NotNull
    private Long id;
    private TranslatedStringDTO name;
    private ImageDTO cover;
}
