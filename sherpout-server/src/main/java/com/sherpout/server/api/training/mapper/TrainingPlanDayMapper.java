package com.sherpout.server.api.training.mapper;

import com.sherpout.server.api.training.dto.TrainingPlanDayDTO;
import com.sherpout.server.api.training.entity.TrainingPlanDay;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;

@Mapper(
        componentModel = "spring",
        uses = TrainingPlanExerciseMapper.class
)
public interface TrainingPlanDayMapper {
    TrainingPlanDayDTO mapToDTO(TrainingPlanDay trainingPlanDay);

    @Mapping(target = "id", ignore = true)
    TrainingPlanDay mapToEntity(TrainingPlanDayDTO dto);

    @Mapping(target = "id", ignore = true)
    @Mapping(target = "exercises", ignore = true)
    TrainingPlanDay mapToUpdateEntity(TrainingPlanDayDTO dto, @MappingTarget TrainingPlanDay trainingPlanDay);
}
