package com.sherpout.server.api.training.dto;

import com.sherpout.server.api.training.entity.TrainingPlan;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDate;
import java.util.UUID;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class AssignedTrainingPlanDTO {
    private UUID assignedUserId;
    private LocalDate assignedDate;
}
