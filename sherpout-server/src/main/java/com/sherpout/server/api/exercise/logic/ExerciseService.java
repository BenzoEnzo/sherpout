package com.sherpout.server.api.exercise.logic;

import com.sherpout.server.api.exercise.dto.ExerciseDTO;
import com.sherpout.server.api.exercise.dto.ExerciseListDTO;
import com.sherpout.server.api.exercise.entity.Exercise;
import com.sherpout.server.api.exercise.mapper.ExerciseMapper;
import com.sherpout.server.api.exercise.repository.ExerciseRepository;
import com.sherpout.server.api.image.dto.ImageDTO;
import com.sherpout.server.api.image.entity.Image;
import com.sherpout.server.api.image.logic.ImageService;
import com.sherpout.server.error.exception.FileException;
import com.sherpout.server.error.exception.UnableToFindExerciseException;
import com.sherpout.server.error.model.ErrorLocationType;
import com.sherpout.server.error.model.ErrorMessage;
import com.sherpout.server.external.storage.StorageService;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.util.Collection;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class ExerciseService {
    private final ExerciseRepository exerciseRepository;
    private final StorageService storageService;
    private final ImageService imageService;
    private final ExerciseMapper exerciseMapper;

    @Transactional
    public ExerciseDTO updateExercise(ExerciseDTO exerciseDTO, Long id, List<MultipartFile> files) {
        Exercise exercise = exerciseRepository.findById(id)
                .orElseThrow(() -> new UnableToFindExerciseException(ErrorLocationType.PATH_PARAM, "id", id));

        exerciseMapper.mapToUpdateEntity(exerciseDTO, exercise);
        imageService.deleteImagesFromBucket(exerciseDTO);
        configureImageSettings(files, exercise, exerciseDTO);

        exerciseRepository.save(exercise);

        return exerciseMapper.mapToDTO(exercise);
    }

    @Transactional
    public ExerciseDTO createExercise(ExerciseDTO exerciseDTO, List<MultipartFile> files) {
        Exercise exercise = exerciseMapper.mapToEntity(exerciseDTO);
        Exercise managed = exerciseRepository.save(exercise);
        configureImageSettings(files, managed, exerciseDTO);

        return exerciseMapper.mapToDTO(managed);
    }

    public ExerciseDTO getExerciseById(Long id) {
        return exerciseRepository.findById(id)
                .map(exerciseMapper::mapToDTO)
                .orElseThrow(() -> new UnableToFindExerciseException(ErrorLocationType.PATH_PARAM, "id", id));
    }

    public List<ExerciseListDTO> getAllExercises() {
        return exerciseRepository.findAll().stream()
                .map(exerciseMapper::mapToListDTO)
                .toList();
    }

    private void configureImageSettings(List<MultipartFile> files, Exercise exercise, ExerciseDTO exerciseDTO) {
        if (files != null && !files.isEmpty()) {
            List<Image> uploadedImages = storageService.uploadFiles(String.valueOf(exercise.getId()), files);
            exercise.getImages().addAll(uploadedImages);
        }

        exercise.setCover(selectImageCover(exerciseDTO, exercise));
    }

    private Image selectImageCover(ExerciseDTO exerciseDTO, Exercise exercise) {
        return Optional.ofNullable(exerciseDTO.getImages())
                .stream()
                .flatMap(Collection::stream)
                .filter(img -> img.getMain().equals(true))
                        .map(ImageDTO::getName)
                        .flatMap(name -> exercise.getImages().stream().filter(img-> img.getName().equals(name)))
                        .findFirst()
                .or(() -> exercise.getImages()
                        .stream()
                        .filter(img -> img.getDeprecated().equals(false))
                        .findFirst())
                        .orElseThrow(() -> new FileException(ErrorMessage.COVER_IMAGE_ERROR, exercise.getName().getEn()));
    }
}
