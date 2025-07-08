package com.sherpout.server.api.training.dto;

import jakarta.validation.Valid;
import jakarta.validation.constraints.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class TrainingPlanDayDTO {
    private Long id;

    @NotNull
    @Min(1)
    @Max(7)
    private Integer number;

    @Valid
    @NotNull
    @NotEmpty
    @Size(min = 1, max = 16)
    private List<TrainingPlanExerciseDTO> exercises;
}
