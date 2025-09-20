package com.sherpout.server.api.training.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.UUID;

@Entity
@Getter @Setter
@NoArgsConstructor
@AllArgsConstructor
public class ActiveTrainingPlan {
    @Id
    private UUID userId;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "training_plan_id", nullable = false)
    private TrainingPlan trainingPlan;

    private LocalDateTime activatedAt;

    @PrePersist
    @PreUpdate
    private void updateActivatedAt() {
        this.activatedAt = LocalDateTime.now();
    }
}
