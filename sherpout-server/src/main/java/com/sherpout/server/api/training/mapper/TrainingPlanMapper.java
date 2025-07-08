package com.sherpout.server.api.training.mapper;

import com.sherpout.server.api.training.dto.TrainingPlanDTO;
import com.sherpout.server.api.training.dto.TrainingPlanDayDTO;
import com.sherpout.server.api.training.entity.TrainingPlan;
import com.sherpout.server.api.training.entity.TrainingPlanDay;
import org.mapstruct.*;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Mapper(
        componentModel = "spring",
        uses = TrainingPlanDayMapper.class
)
public abstract class TrainingPlanMapper {
    @Autowired
    protected TrainingPlanDayMapper trainingPlanDayMapper;

    public abstract TrainingPlanDTO mapToDTO(TrainingPlan trainingPlan);

    @Mapping(target = "id", ignore = true)
    public abstract TrainingPlan mapToEntity(TrainingPlanDTO dto);

    @Mapping(target = "id", ignore = true)
    @Mapping(target = "days", ignore = true)
    public abstract TrainingPlan mapToUpdateEntity(TrainingPlanDTO dto, @MappingTarget TrainingPlan trainingPlan);

    @AfterMapping
    protected void mapDays(TrainingPlanDTO dto, @MappingTarget TrainingPlan trainingPlan) {
        updateTrainingPlanDays(trainingPlan.getDays(), dto.getDays(), trainingPlan);
    }

    public void updateTrainingPlanDays(List<TrainingPlanDay> entities, List<TrainingPlanDayDTO> dtos, TrainingPlan trainingPlan) {
        Map<Long, TrainingPlanDay> entitiesMap = entities.stream()
                .collect(Collectors.toMap(TrainingPlanDay::getId, day -> day));

        entities.clear();

        entities.addAll(dtos.stream()
                .map(dayDto -> createOrUpdateDay(entitiesMap.get(dayDto.getId()), dayDto))
                .peek(day -> day.setTrainingPlan(trainingPlan))
                .toList());
    }

    private TrainingPlanDay createOrUpdateDay(TrainingPlanDay entity, TrainingPlanDayDTO dto) {
        return entity == null
                ? trainingPlanDayMapper.mapToEntity(dto)
                : trainingPlanDayMapper.mapToUpdateEntity(dto, entity);
    }
}
