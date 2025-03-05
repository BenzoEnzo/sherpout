package com.sherpout.server.api.exercise.mapper;

import com.sherpout.server.api.exercise.dto.ExerciseSelectDTO;
import com.sherpout.server.api.exercise.entity.Exercise;
import com.sherpout.server.api.exercise.repository.ExerciseRepository;
import lombok.RequiredArgsConstructor;
import org.mapstruct.Named;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class ExerciseMapperHelper {
    private final ExerciseRepository exerciseRepository;

    @Named("mapSelectToExercise")
    public Exercise mapSelectToExercise(ExerciseSelectDTO dto) {
        if (dto == null || dto.getId() == null) {
            return null;
        }
        return exerciseRepository
                .findById(dto.getId())
                .orElseThrow(IllegalAccessError::new);
    }
}
