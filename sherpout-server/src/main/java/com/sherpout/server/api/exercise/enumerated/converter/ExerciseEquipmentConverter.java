package com.sherpout.server.api.exercise.enumerated.converter;

import com.sherpout.server.api.exercise.enumerated.ExerciseEquipment;
import com.sherpout.server.commons.enumerated.BaseEnumConverter;
import jakarta.persistence.Converter;

@Converter(autoApply = true)
public class ExerciseEquipmentConverter extends BaseEnumConverter<ExerciseEquipment> {
    public ExerciseEquipmentConverter() {
        super(ExerciseEquipment.class);
    }
}
