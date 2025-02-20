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
    private UUID uuid;

    private LocalDateTime timestamp;

    public ExerciseLike(Exercise exercise, UUID uuid) {
        this.exercise = exercise;
        this.uuid = uuid;
        this.timestamp = LocalDateTime.now();
    }
}
