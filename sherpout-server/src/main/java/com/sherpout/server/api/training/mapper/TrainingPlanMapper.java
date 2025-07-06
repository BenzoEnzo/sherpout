package com.sherpout.server.api.training.mapper;

import com.sherpout.server.api.training.dto.TrainingPlanDTO;
import com.sherpout.server.api.training.entity.TrainingPlan;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;

@Mapper(
        componentModel = "spring",
        uses = TrainingPlanDayMapper.class
)
public interface TrainingPlanMapper {
    TrainingPlanDTO mapToDTO(TrainingPlan trainingPlan);

    @Mapping(target = "id", ignore = true)
    TrainingPlan mapToEntity(TrainingPlanDTO dto);

    @Mapping(target = "id", ignore = true)
    @Mapping(target = "days", ignore = true)
    TrainingPlan mapToUpdateEntity(TrainingPlanDTO dto, @MappingTarget TrainingPlan trainingPlan);
}
