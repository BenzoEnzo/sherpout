package com.sherpout.server.api.exercise.logic;

import com.sherpout.server.api.exercise.dto.ExerciseDTO;
import com.sherpout.server.api.exercise.dto.ExerciseListDTO;
import com.sherpout.server.api.exercise.entity.Exercise;
import com.sherpout.server.api.exercise.enumerated.MuscleCategory;
import com.sherpout.server.api.exercise.mapper.ExerciseMapper;
import com.sherpout.server.api.exercise.repository.ExerciseRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class ExerciseService {
    private final ExerciseRepository exerciseRepository;
    private final ExerciseMapper exerciseMapper;

    public ExerciseDTO createExercise(ExerciseDTO dto) {
        Exercise exercise = exerciseRepository.save(exerciseMapper.mapToEntity(dto));
        return exerciseMapper.mapToDTO(exercise);
    }

    public ExerciseDTO getExerciseById(Long id) {
        return exerciseRepository.findById(id)
                .map(exerciseMapper::mapToDTO)
                .orElseThrow(IllegalArgumentException::new);
    }

    public Map<MuscleCategory, List<ExerciseListDTO>> getAllExercises() {
        return exerciseRepository.findAll().stream()
                .collect(Collectors.groupingBy(
                        exercise -> exercise.getTargetMuscle().getCategory(),
                        Collectors.mapping(exerciseMapper::mapToListDTO, Collectors.toList())
                ));
    }
}
