package com.sherpout.server.api.exercise.enumerated.converter;

import com.sherpout.server.api.exercise.enumerated.ExerciseDifficulty;
import com.sherpout.server.commons.enumerated.BaseEnumConverter;
import jakarta.persistence.Converter;

@Converter(autoApply = true)
public class ExerciseDifficultyConverter extends BaseEnumConverter<ExerciseDifficulty> {
    public ExerciseDifficultyConverter() {
        super(ExerciseDifficulty.class);
    }
}
