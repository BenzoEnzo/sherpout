package com.sherpout.server.api.training.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDate;
import java.util.Objects;
import java.util.UUID;

@Entity
@Getter
@NoArgsConstructor
public class AssignedTrainingPlan  {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private UUID assignedUserId;

    private final LocalDate assignedDate = LocalDate.now();

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "training_plan_id")
    private TrainingPlan trainingPlan;

    public AssignedTrainingPlan(TrainingPlan trainingPlan, UUID userId) {
        this.trainingPlan = trainingPlan;
        this.assignedUserId = userId;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof AssignedTrainingPlan other)) return false;
        return Objects.equals(assignedUserId, other.assignedUserId) &&
                Objects.equals(
                        trainingPlan != null ? trainingPlan.getId() : null,
                        other.trainingPlan != null ? other.trainingPlan.getId() : null);
    }

    @Override
    public int hashCode() {
        return Objects.hash(
                assignedUserId,
                trainingPlan != null ? trainingPlan.getId() : null
        );
    }
}
