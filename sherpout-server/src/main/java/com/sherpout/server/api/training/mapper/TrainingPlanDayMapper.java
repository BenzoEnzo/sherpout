package com.sherpout.server.api.training.mapper;

import com.sherpout.server.api.training.dto.TrainingPlanDayDTO;
import com.sherpout.server.api.training.dto.TrainingPlanExerciseDTO;
import com.sherpout.server.api.training.entity.TrainingPlanDay;
import com.sherpout.server.api.training.entity.TrainingPlanExercise;
import org.mapstruct.AfterMapping;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Mapper(
        componentModel = "spring",
        uses = TrainingPlanExerciseMapper.class
)
public abstract class TrainingPlanDayMapper {
    @Autowired
    private TrainingPlanExerciseMapper trainingPlanExerciseMapper;

    public abstract TrainingPlanDayDTO mapToDTO(TrainingPlanDay trainingPlanDay);

    @Mapping(target = "id", ignore = true)
    @Mapping(target = "exercises", ignore = true)
    public abstract TrainingPlanDay mapToEntity(TrainingPlanDayDTO dto);

    @Mapping(target = "id", ignore = true)
    @Mapping(target = "exercises", ignore = true)
    public abstract TrainingPlanDay mapToUpdateEntity(TrainingPlanDayDTO dto, @MappingTarget TrainingPlanDay trainingPlanDay);

    @AfterMapping
    protected void mapDays(TrainingPlanDayDTO dto, @MappingTarget TrainingPlanDay trainingPlanDay) {
        updateTrainingPlanExercises(trainingPlanDay.getExercises(), dto.getExercises(), trainingPlanDay);
    }

    public void updateTrainingPlanExercises(List<TrainingPlanExercise> entities, List<TrainingPlanExerciseDTO> dtos, TrainingPlanDay day) {
        Map<Long, TrainingPlanExercise> entitiesMap = entities.stream()
                .collect(Collectors.toMap(TrainingPlanExercise::getId, exercise -> exercise));

        entities.clear();

        entities.addAll(dtos.stream()
                .map(dayDto -> createOrUpdateExercise(entitiesMap.get(dayDto.getId()), dayDto))
                .peek(exercise -> exercise.setTrainingPlanDay(day))
                .toList());
    }

    private TrainingPlanExercise createOrUpdateExercise(TrainingPlanExercise entity, TrainingPlanExerciseDTO dto) {
        return entity == null
                ? trainingPlanExerciseMapper.mapToEntity(dto)
                : trainingPlanExerciseMapper.mapToUpdateEntity(dto, entity);
    }
}
