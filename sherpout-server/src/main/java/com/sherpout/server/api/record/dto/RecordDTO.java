package com.sherpout.server.api.record.dto;

import com.sherpout.server.api.exercise.dto.ExerciseDTO;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.UUID;

@Getter
@Setter
public class RecordDTO {
    private Long id;
    private LocalDateTime date;
    private Integer value;
    private UUID userId;
    private Long exerciseId;
    private ExerciseDTO exercise;
}
