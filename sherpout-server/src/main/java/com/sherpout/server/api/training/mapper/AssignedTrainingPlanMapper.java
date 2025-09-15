package com.sherpout.server.api.training.mapper;

import com.sherpout.server.api.training.dto.AssignedTrainingPlanDTO;
import com.sherpout.server.api.training.entity.AssignedTrainingPlan;
import org.mapstruct.Mapper;

@Mapper(componentModel = "spring")
public interface AssignedTrainingPlanMapper {

    AssignedTrainingPlanDTO mapToDTO(AssignedTrainingPlan assignedTrainingPlan);
}
