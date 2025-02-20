package com.sherpout.server.api.exercise.entity;

import lombok.AllArgsConstructor;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

import java.util.UUID;

@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode
public class ExerciseLikeId {
    private Long exerciseId;
    private UUID userId;
}
