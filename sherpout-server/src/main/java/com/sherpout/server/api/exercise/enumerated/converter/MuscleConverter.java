package com.sherpout.server.api.exercise.enumerated.converter;

import com.sherpout.server.api.exercise.enumerated.Muscle;
import com.sherpout.server.commons.enumerated.BaseEnumConverter;
import jakarta.persistence.Converter;

@Converter(autoApply = true)
public class MuscleConverter extends BaseEnumConverter<Muscle> {
    public MuscleConverter() {
        super(Muscle.class);
    }
}
