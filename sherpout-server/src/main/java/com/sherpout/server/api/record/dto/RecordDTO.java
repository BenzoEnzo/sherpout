package com.sherpout.server.api.record.dto;

import com.sherpout.server.api.exercise.dto.ExerciseSelectDTO;
import com.sherpout.server.commons.validation.PastOrNow;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
public class RecordDTO {
    private Long id;

    @NotNull
    @PastOrNow
    private LocalDateTime date;

    @NotNull
    private Integer value;

    @Valid
    @NotNull
    private ExerciseSelectDTO exercise;
}
