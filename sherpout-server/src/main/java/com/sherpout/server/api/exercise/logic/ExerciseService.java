package com.sherpout.server.api.exercise.logic;

import com.sherpout.server.api.exercise.dto.ExerciseDTO;
import com.sherpout.server.api.exercise.entity.Exercise;
import com.sherpout.server.api.exercise.mapper.ExerciseMapper;
import com.sherpout.server.api.exercise.repository.ExerciseRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

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

    public List<ExerciseDTO> getAllExercises() {
        return exerciseRepository.findAll().stream()
                .map(exerciseMapper::mapToDTO)
                .toList();
    }
}
