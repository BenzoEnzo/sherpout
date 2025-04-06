package com.sherpout.server.api.exercise.logic;

import com.sherpout.server.api.exercise.dto.ExerciseDTO;
import com.sherpout.server.api.exercise.dto.ExerciseListDTO;
import com.sherpout.server.api.exercise.entity.Exercise;
import com.sherpout.server.api.exercise.enumerated.MuscleCategory;
import com.sherpout.server.api.exercise.mapper.ExerciseMapper;
import com.sherpout.server.api.exercise.repository.ExerciseRepository;
import com.sherpout.server.commons.dto.ImageDTO;
import com.sherpout.server.error.exception.UnableToFindExerciseException;
import com.sherpout.server.error.model.ErrorLocationType;
import com.sherpout.server.external.storage.StorageService;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class ExerciseService {
    private final ExerciseRepository exerciseRepository;
    private final StorageService storageService;
    private final ExerciseMapper exerciseMapper;

    @Transactional
    public ExerciseDTO updateExercise(ExerciseDTO exerciseDTO, Long id, List<MultipartFile> files) {
        Exercise exercise = exerciseRepository.findById(id)
                .orElseThrow(() -> new UnableToFindExerciseException(ErrorLocationType.PATH_PARAM, "id", id));

        configureFileSettings(files, exerciseDTO);
        exerciseMapper.mapToUpdateEntity(exerciseDTO, exercise);

        return exerciseMapper.mapToDTO(exercise);
    }

    @Transactional
    public ExerciseDTO createExercise(ExerciseDTO exerciseDTO, List<MultipartFile> files) {
        configureFileSettings(files, exerciseDTO);
        Exercise exercise = exerciseMapper.mapToEntity(exerciseDTO);

        return exerciseMapper.mapToDTO(exerciseRepository.save(exercise));
    }

    public ExerciseDTO getExerciseById(Long id) {
        return exerciseRepository.findById(id)
                .map(exerciseMapper::mapToDTO)
                .orElseThrow(() -> new UnableToFindExerciseException(ErrorLocationType.PATH_PARAM, "id", id));
    }

    public Map<MuscleCategory, List<ExerciseListDTO>> getAllExercises() {
        return exerciseRepository.findAll().stream()
                .collect(Collectors.groupingBy(
                        exercise -> exercise.getTargetMuscle().getCategory(),
                        Collectors.mapping(exerciseMapper::mapToListDTO, Collectors.toList())
                ));
    }

    private void configureFileSettings(List<MultipartFile> files, ExerciseDTO dto){
        if(files != null && files.isEmpty()) {
            List<ImageDTO> uploadedFiles = storageService.uploadFiles(String.valueOf(dto.getId()), files);
            dto.setCover(uploadedFiles.getFirst());
            dto.setImages(uploadedFiles);
        }
    }
}
