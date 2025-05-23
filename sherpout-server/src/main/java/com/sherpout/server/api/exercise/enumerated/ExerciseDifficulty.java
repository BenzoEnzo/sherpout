package com.sherpout.server.api.exercise.enumerated;

import com.sherpout.server.commons.enumerated.BaseEnum;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum ExerciseDifficulty implements BaseEnum {
    EASY(1),
    MEDIUM(2),
    HARD(3);

    private final Integer id;
}
