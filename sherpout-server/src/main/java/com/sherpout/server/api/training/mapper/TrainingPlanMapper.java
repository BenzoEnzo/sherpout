package com.sherpout.server.api.training.mapper;

import com.sherpout.server.api.training.dto.TrainingPlanDTO;
import com.sherpout.server.api.training.entity.TrainingPlan;
import com.sherpout.server.api.training.entity.TrainingPlanDay;
import org.mapstruct.AfterMapping;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;

@Mapper(
        componentModel = "spring",
        uses = {TrainingPlanDayMapper.class, AssignedTrainingPlanMapper.class}
)
public interface TrainingPlanMapper {
    TrainingPlanDTO mapToDTO(TrainingPlan trainingPlan);

    @Mapping(target = "id", ignore = true)
    @Mapping(target = "assignments", ignore = true)
    TrainingPlan mapToEntity(TrainingPlanDTO dto);

    @Mapping(target = "id", ignore = true)
    @Mapping(target = "days", ignore = true)
    @Mapping(target = "assignments", ignore = true)
    TrainingPlan mapToUpdateEntity(TrainingPlanDTO dto, @MappingTarget TrainingPlan trainingPlan);

    @AfterMapping
    default void setBackReference(@MappingTarget TrainingPlan plan) {
        for (TrainingPlanDay day : plan.getDays()) {
            day.setTrainingPlan(plan);
        }
    }
}
