package com.sherpout.server.api.exercise.enumerated;

import com.sherpout.server.commons.enumerated.BaseEnum;
import lombok.AllArgsConstructor;
import lombok.Getter;

import java.util.Arrays;
import java.util.List;

@Getter
@AllArgsConstructor
public enum Muscle implements BaseEnum {
    UPPER_CHEST(1, "upper chest", "górna część klatki", MuscleCategory.CHEST),
    MID_CHEST(2, "mid chest", "środkowa część klatki", MuscleCategory.CHEST),
    LOWER_CHEST(3, "lower chest", "dolna część klatki", MuscleCategory.CHEST),
    OTHER_CHEST(4, "other", "pozostałe", MuscleCategory.CHEST),

    LATS(5, "lats", "najszersze", MuscleCategory.BACK),
    MID_BACK(6, "mid back", "środkowa część pleców", MuscleCategory.BACK),
    TRAPS(7, "traps", "czworoboczny", MuscleCategory.BACK),
    LOWER_BACK(8, "lower back", "dolna część pleców", MuscleCategory.BACK),
    OTHER_BACK(9, "other", "pozostałe", MuscleCategory.BACK),

    FRONT_DELTS(10, "front delts", "przód barków", MuscleCategory.DELTS),
    SIDE_DELTS(11, "side delts", "bok barków", MuscleCategory.DELTS),
    BACK_DELTS(12, "rear delts", "tył barków", MuscleCategory.DELTS),

    QUADS(13, "quads", "czworogłowe", MuscleCategory.LEGS),
    HAMSTRINGS(14, "hamstrings", "dwugłowe", MuscleCategory.LEGS),
    CALVES(15, "calves", "łydki", MuscleCategory.LEGS),
    GLUTES(16, "glutes", "pośladki", MuscleCategory.LEGS),

    UPPER_ABS(17, "upper abs", "górna część brzucha", MuscleCategory.ABS),
    LOWER_ABS(18, "lower abs", "dolna część brzucha", MuscleCategory.ABS),
    OBLIQUES(19, "obliques", "skośne", MuscleCategory.ABS);

    private final Integer id;
    private final String en;
    private final String pl;
    private final MuscleCategory category;

    public static List<Muscle> findByCategory(MuscleCategory category) {
        return Arrays.stream(Muscle.values())
                .filter(muscle -> muscle.category == category)
                .toList();
    }

}
