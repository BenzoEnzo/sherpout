package com.sherpout.server.api.record.dto;

import com.sherpout.server.api.exercise.dto.ExerciseSelectDTO;
import com.sherpout.server.commons.validation.PastOrNow;
import jakarta.validation.Valid;
import jakarta.validation.constraints.*;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
public class RecordDTO {
    @Null
    private Long id;

    @NotNull
    @PastOrNow
    private LocalDateTime date;

    @Min(1)
    @Max(1000)
    @NotNull
    private Double value;

    @Valid
    @NotNull
    private ExerciseSelectDTO exercise;
}
