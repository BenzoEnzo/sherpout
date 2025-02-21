package com.sherpout.server.api.exercise.controller.param;

import com.sherpout.server.api.exercise.enumerated.ExerciseDifficulty;
import com.sherpout.server.api.exercise.enumerated.ExerciseEquipment;
import com.sherpout.server.api.exercise.enumerated.Muscle;
import com.sherpout.server.commons.param.KeywordQueryParam;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class ExerciseQueryParam extends KeywordQueryParam {
    private List<ExerciseDifficulty> difficulties;
    private List<Muscle> muscles;
    private List<ExerciseEquipment> equipments;
}










