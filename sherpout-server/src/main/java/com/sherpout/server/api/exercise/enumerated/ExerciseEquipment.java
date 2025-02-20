package com.sherpout.server.api.exercise.enumerated;

import com.sherpout.server.commons.enumerated.BaseEnum;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum ExerciseEquipment implements BaseEnum {
    BARBELL(1),
    DUMBBELL(2),
    KETTLEBELL(3),
    RESISTANCE_BAND(4),
    MACHINE(5),
    CABLE_MACHINE(6),
    PLATFORM(7),
    BENCH(8),
    PULL_UP_BAR(9);

    private final Integer id;
}
