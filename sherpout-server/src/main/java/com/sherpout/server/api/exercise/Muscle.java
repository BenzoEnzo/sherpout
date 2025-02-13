package com.sherpout.server.api.exercise;

import lombok.AllArgsConstructor;
import lombok.Getter;

import java.util.Arrays;
import java.util.List;

@Getter
@AllArgsConstructor
public enum Muscle {
    UPPER_CHEST("upper chest", "górna część klatki", MuscleCategory.CHEST),
    MID_CHEST("mid chest", "środkowa część klatki", MuscleCategory.CHEST),
    LOWER_CHEST("lower chest", "dolna część klatki", MuscleCategory.CHEST),
    OTHER_CHEST("other", "pozostałe", MuscleCategory.CHEST),

    LATS("lats", "najszersze", MuscleCategory.BACK),
    MID_BACK("mid back", "środkowa część pleców", MuscleCategory.BACK),
    TRAPS("traps", "czworoboczny", MuscleCategory.BACK),
    LOWER_BACK("lower back", "dolna część pleców", MuscleCategory.BACK),
    OTHER_BACK("other", "pozostałe", MuscleCategory.BACK),

    FRONT_DELTS("front delts", "przód barków", MuscleCategory.DELTS),
    SIDE_DELTS("side delts", "bok barków", MuscleCategory.DELTS),
    BACK_DELTS("rear delts", "tył barków", MuscleCategory.DELTS),

    QUADS("quads", "czworogłowe", MuscleCategory.LEGS),
    HAMSTRINGS("hamstrings", "dwugłowe", MuscleCategory.LEGS),
    CALVES("calves", "łydki", MuscleCategory.LEGS),
    GLUTES("glutes", "pośladki", MuscleCategory.LEGS),

    UPPER_ABS("upper abs", "górna część brzucha", MuscleCategory.ABS),
    LOWER_ABS("lower abs", "dolna część brzucha", MuscleCategory.ABS),
    OBLIQUES("obliques", "skośne", MuscleCategory.ABS);

    private final String en;
    private final String pl;
    private final MuscleCategory category;

    public static List<Muscle> findByCategory(MuscleCategory category) {
        return Arrays.stream(Muscle.values())
                .filter(muscle -> muscle.category == category)
                .toList();
    }

}
