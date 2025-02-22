package com.sherpout.server.api.record.dto;

import com.sherpout.server.api.exercise.dto.ExerciseDTO;
import lombok.Getter;
import lombok.Setter;

import java.time.ZonedDateTime;
import java.util.UUID;

@Getter
@Setter
public class RecordDTO {
    private Long id;
    private ZonedDateTime date;
    private Integer value;
    private UUID userId;
    private ExerciseDTO exercise;
}
