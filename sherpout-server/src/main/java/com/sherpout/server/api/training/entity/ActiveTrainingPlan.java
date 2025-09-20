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
    @JoinColumn(name = "training_plan_id",
            foreignKey = @ForeignKey(name = "fk_atp_plan"))
    private TrainingPlan trainingPlan;

    private LocalDateTime activatedAt;
}
