package com.sherpout.server.api.training.logic;

import com.sherpout.server.api.training.dto.TrainingPlanDayDTO;
import com.sherpout.server.api.training.dto.TrainingPlanExerciseDTO;
import com.sherpout.server.api.training.entity.TrainingPlan;
import com.sherpout.server.api.training.entity.TrainingPlanDay;
import com.sherpout.server.api.training.entity.TrainingPlanExercise;
import com.sherpout.server.api.training.mapper.TrainingPlanDayMapper;
import com.sherpout.server.api.training.mapper.TrainingPlanExerciseMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Component
@RequiredArgsConstructor
public class TrainingPlanUpdateHelper {
    private final TrainingPlanDayMapper trainingPlanDayMapper;
    private final TrainingPlanExerciseMapper trainingPlanExerciseMapper;

    public void updateDays(TrainingPlan plan, List<TrainingPlanDayDTO> dtos) {
        Map<Long, TrainingPlanDay> entitiesMap = plan.getDays().stream()
                .collect(Collectors.toMap(TrainingPlanDay::getId, day -> day));

        plan.getDays().clear();

        plan.getDays().addAll(dtos.stream()
                .map(dayDto -> createOrUpdateDay(entitiesMap.get(dayDto.getId()), dayDto))
                .peek(day -> day.setTrainingPlan(plan))
                .toList());
    }

    private TrainingPlanDay createOrUpdateDay(TrainingPlanDay entity, TrainingPlanDayDTO dto) {
        TrainingPlanDay day = entity == null
                ? trainingPlanDayMapper.mapToEntity(dto)
                : trainingPlanDayMapper.mapToUpdateEntity(dto, entity);

        updateExercises(day, dto.getExercises());

        return day;
    }

    private void updateExercises(TrainingPlanDay day, List<TrainingPlanExerciseDTO> dtos) {
        Map<Long, TrainingPlanExercise> entitiesMap = day.getExercises().stream()
                .collect(Collectors.toMap(TrainingPlanExercise::getId, exercise -> exercise));

        day.getExercises().clear();

        day.getExercises().addAll(dtos.stream()
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
