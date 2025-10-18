package com.sherpout.server.api.training.mapper;

import com.sherpout.server.api.training.dto.TrainingPlanDTO;
import com.sherpout.server.api.training.dto.TrainingPlanListDTO;
import com.sherpout.server.api.training.entity.TrainingPlan;
import com.sherpout.server.api.training.entity.TrainingPlanDay;
import com.sherpout.server.api.training.entity.TrainingPlanExercise;
import org.mapstruct.AfterMapping;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;

@Mapper(
        componentModel = "spring",
        uses = TrainingPlanDayMapper.class
)
public interface TrainingPlanMapper {
    @Mapping(target = "id", ignore = true)
    TrainingPlanDTO mapToDTO(TrainingPlan trainingPlan);

    TrainingPlanListDTO mapToListDTO(TrainingPlan trainingPlan);

    @Mapping(target = "id", ignore = true)
    TrainingPlan mapToEntity(TrainingPlanDTO dto);

    @Mapping(target = "id", ignore = true)
    @Mapping(target = "days", ignore = true)
    TrainingPlan mapToUpdateEntity(TrainingPlanDTO dto, @MappingTarget TrainingPlan trainingPlan);

    @AfterMapping
    default void setBackReference(@MappingTarget TrainingPlan plan) {
        if (plan.getId() != null) {
            return;
        }

        for (TrainingPlanDay day : plan.getDays()) {
            day.setTrainingPlan(plan);
        }
    }

    @AfterMapping
    default void setSetsNumber(@MappingTarget TrainingPlanListDTO dto, TrainingPlan trainingPlan) {
        int setsNumber = trainingPlan.getDays().stream()
                .flatMap(day -> day.getExercises().stream())
                .mapToInt(TrainingPlanExercise::getSets)
                .sum();

        dto.setSetsNumber(setsNumber);
    }
}
