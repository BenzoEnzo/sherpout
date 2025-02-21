package com.sherpout.server.api.exercise.enumerated;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum MuscleCategory {
    CHEST("chest", "klata"),
    BACK("back", "plecy"),
    DELTS("delts", "barki"),
    ARMS("arms", "ramiona"),
    LEGS("legs", "nogi"),
    ABS("abs", "brzuch");

    private final String en;
    private final String pl;
}
