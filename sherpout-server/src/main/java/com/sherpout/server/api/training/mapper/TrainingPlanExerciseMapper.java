package com.sherpout.server.api.training.mapper;

import com.sherpout.server.api.exercise.mapper.ExerciseMapper;
import com.sherpout.server.api.exercise.mapper.ExerciseMapperHelper;
import com.sherpout.server.api.training.dto.TrainingPlanExerciseDTO;
import com.sherpout.server.api.training.entity.TrainingPlanExercise;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;

@Mapper(
        componentModel = "spring",
        uses = {
                ExerciseMapper.class,
                ExerciseMapperHelper.class,
        })
public interface TrainingPlanExerciseMapper {
    TrainingPlanExerciseDTO mapToDTO(TrainingPlanExercise trainingPlanExercise);

    @Mapping(target = "id", ignore = true)
    @Mapping(target = "exercise", source = "exercise", qualifiedByName = "mapSelectToExercise")
    TrainingPlanExercise mapToEntity(TrainingPlanExerciseDTO dto);

    @Mapping(target = "id", ignore = true)
    @Mapping(target = "exercise", source = "exercise", qualifiedByName = "mapSelectToExercise")
    TrainingPlanExercise mapToUpdateEntity(TrainingPlanExerciseDTO dto, @MappingTarget TrainingPlanExercise trainingPlanExercise);
}
