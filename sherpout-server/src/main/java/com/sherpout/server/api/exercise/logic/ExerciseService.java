package com.sherpout.server.api.exercise.logic;

import com.sherpout.server.api.exercise.dto.ExerciseDTO;
import com.sherpout.server.api.exercise.dto.ExerciseListDTO;
import com.sherpout.server.api.exercise.entity.Exercise;
import com.sherpout.server.api.exercise.mapper.ExerciseMapper;
import com.sherpout.server.api.exercise.repository.ExerciseRepository;
import com.sherpout.server.commons.dto.pagination.PageResponseDTO;
import com.sherpout.server.commons.dto.pagination.PaginationDTO;
import com.sherpout.server.commons.service.PaginationService;
import com.sherpout.server.error.exception.SingleApiErrorException;
import com.sherpout.server.error.model.ApiError;
import com.sherpout.server.error.model.ErrorLocationType;
import com.sherpout.server.error.model.ErrorMessage;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class ExerciseService {
    private final ExerciseRepository exerciseRepository;
    private final ExerciseMapper exerciseMapper;
    private final PaginationService paginationService;

    @Transactional
    public ExerciseDTO updateExercise(ExerciseDTO updateRequest, Long id) {
        Exercise exercise = exerciseRepository.findById(id)
                .orElseThrow(() -> new SingleApiErrorException(
                        ApiError.builder(ErrorMessage.INVALID_INPUT, HttpStatus.NOT_FOUND)
                                .withErrorLocationType(ErrorLocationType.PATH_PARAM)
                                .withLocation("id")
                                .withTextParam("name", "id: " + id)
                ));

        exerciseMapper.mapToUpdateEntity(updateRequest, exercise);

        return exerciseMapper.mapToDTO(exercise);
    }

    public ExerciseDTO createExercise(ExerciseDTO dto) {
        Exercise exercise = exerciseRepository.save(exerciseMapper.mapToEntity(dto));
        return exerciseMapper.mapToDTO(exercise);
    }

    public ExerciseDTO getExerciseById(Long id) {
        return exerciseRepository.findById(id)
                .map(exerciseMapper::mapToDTO)
                .orElseThrow(IllegalArgumentException::new);
    }

    public PageResponseDTO<ExerciseListDTO> getAllExercises(PaginationDTO pagination) {
        PageRequest pageRequest = paginationService.getPageRequest(pagination);
        Page<Exercise> exercisesPage = exerciseRepository.findAll(pageRequest);
        return paginationService.mapToPage(exercisesPage.stream().map(exerciseMapper::mapToListDTO), exercisesPage);
    }
}
