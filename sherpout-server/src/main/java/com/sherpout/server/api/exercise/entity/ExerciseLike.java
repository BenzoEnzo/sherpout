package com.sherpout.server.api.exercise.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.UUID;

@Getter
@Setter
@Entity
@IdClass(ExerciseLikeId.class)
@NoArgsConstructor
public class ExerciseLike {
    @Id
    @ManyToOne
    @JoinColumn(name = "exercise_id", nullable = false)
    private Exercise exercise;

    @Id
    private UUID userId;

    private LocalDateTime timestamp;

    public ExerciseLike(Exercise exercise, UUID userId) {
        this.exercise = exercise;
        this.userId = userId;
        this.timestamp = LocalDateTime.now();
    }
}
