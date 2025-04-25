package com.sherpout.server.api.exercise.dto;

import com.sherpout.server.api.exercise.enumerated.ExerciseDifficulty;
import com.sherpout.server.api.exercise.enumerated.ExerciseEquipment;
import com.sherpout.server.api.exercise.enumerated.Muscle;
import com.sherpout.server.commons.dto.ImageDTO;
import com.sherpout.server.commons.dto.TranslatedStringDTO;
import com.sherpout.server.commons.validation.TranslatedStringValid;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Null;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

import java.util.List;
import java.util.Set;

@Getter
@Setter
public class ExerciseDTO {
    @Null
    private Long id;

    @NotNull
    @TranslatedStringValid
    private TranslatedStringDTO name;

    @NotNull
    @TranslatedStringValid
    private TranslatedStringDTO description;

    @NotNull
    private ExerciseDifficulty difficulty;

    @NotNull
    private Muscle targetMuscle;

    private Set<Muscle> supportMuscles;

    private Set<ExerciseEquipment> equipments;

    @Null
    private Integer likesNumber;

    private ImageDTO cover;

    private List<ImageDTO> images;
}
