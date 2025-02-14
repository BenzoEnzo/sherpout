package com.sherpout.server.api.exercise.dto;

import com.sherpout.server.api.exercise.enumerated.ExerciseDifficulty;
import com.sherpout.server.api.exercise.enumerated.ExerciseEquipment;
import com.sherpout.server.api.exercise.enumerated.Muscle;
import com.sherpout.server.commons.dto.ImageDTO;
import com.sherpout.server.commons.dto.TranslatedStringDTO;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class ExerciseDTO {
    private Long id;
    private TranslatedStringDTO name;
    private TranslatedStringDTO description;
    private ExerciseDifficulty difficulty;
    private Muscle targetMuscle;
    private List<Muscle> supportMuscles;
    private List<ExerciseEquipment> equipments;
    private ImageDTO cover;
    private List<ImageDTO> images;
}
