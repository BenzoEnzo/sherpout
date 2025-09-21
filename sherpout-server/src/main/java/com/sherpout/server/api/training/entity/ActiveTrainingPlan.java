package com.sherpout.server.api.training.entity;

import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;
import java.util.UUID;

@Entity
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class ActiveTrainingPlan {
    @Id
    private UUID userId;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "training_plan_id", nullable = false)
    private TrainingPlan trainingPlan;

    private LocalDateTime activatedAt;

    public ActiveTrainingPlan(UUID userId, TrainingPlan trainingPlan) {
        this.userId = userId;
        this.trainingPlan = trainingPlan;
    }

    @PrePersist
    @PreUpdate
    private void updateActivatedAt() {
        this.activatedAt = LocalDateTime.now();
    }
}
