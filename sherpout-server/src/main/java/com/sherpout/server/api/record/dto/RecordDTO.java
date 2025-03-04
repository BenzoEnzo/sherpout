package com.sherpout.server.api.record.dto;

import com.sherpout.server.api.exercise.dto.ExerciseSelectDTO;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Null;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
public class RecordDTO {
    @Null
    private Long id;

    @NotNull
    private LocalDateTime date;

    @NotNull
    private Integer value;

    @Valid
    @NotNull
    private ExerciseSelectDTO exercise;
}
