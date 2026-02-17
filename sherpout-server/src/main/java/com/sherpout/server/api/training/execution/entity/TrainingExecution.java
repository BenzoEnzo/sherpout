package com.sherpout.server.api.training.execution.entity;

import com.sherpout.server.api.training.entity.TrainingPlan;
import com.sherpout.server.config.security.ownership.Ownable;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;
import java.util.UUID;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class TrainingExecution implements Ownable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private UUID userId;

    @ManyToOne
    @JoinColumn(name = "plan_id")
    private TrainingPlan plan;

    private TrainingExecutionStatus status;

    @OneToMany(mappedBy = "execution", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<TrainingExecutionExercise> exercises;
}
