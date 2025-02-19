package com.sherpout.server.api.exercise.dto;

import com.sherpout.server.api.exercise.enumerated.ExerciseDifficulty;
import com.sherpout.server.api.exercise.enumerated.Muscle;
import com.sherpout.server.commons.dto.ImageDTO;
import com.sherpout.server.commons.dto.TranslatedStringDTO;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

import java.util.Set;

@Getter
@Setter
public class ExerciseListDTO {
    private Long id;
    private TranslatedStringDTO name;
    private ExerciseDifficulty difficulty;
    private Muscle targetMuscle;
    private Set<Muscle> supportMuscles;
    private ImageDTO cover;
}
