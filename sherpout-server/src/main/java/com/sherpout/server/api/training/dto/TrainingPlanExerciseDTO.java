package com.sherpout.server.api.training.dto;

import com.sherpout.server.api.exercise.dto.ExerciseSelectDTO;
import jakarta.validation.Valid;
import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class TrainingPlanExerciseDTO {
    private Long id;

    @Valid
    @NotNull
    private ExerciseSelectDTO exercise;

    @NotNull
    @Min(1)
    @Max(16)
    private Integer sets;
}
