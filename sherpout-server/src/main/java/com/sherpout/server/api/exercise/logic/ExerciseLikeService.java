package com.sherpout.server.api.exercise.logic;

import com.sherpout.server.api.exercise.dto.LikeNumberResponseDTO;
import com.sherpout.server.api.exercise.entity.Exercise;
import com.sherpout.server.api.exercise.entity.ExerciseLike;
import com.sherpout.server.api.exercise.repository.ExerciseLikeRepository;
import com.sherpout.server.api.exercise.repository.ExerciseRepository;
import com.sherpout.server.error.exception.UnableToFindExerciseException;
import com.sherpout.server.error.model.ErrorLocationType;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.UUID;

@Service
@RequiredArgsConstructor
public class ExerciseLikeService {
    private final ExerciseRepository exerciseRepository;
    private final ExerciseLikeRepository exerciseLikeRepository;

    @Transactional
    public LikeNumberResponseDTO toggleLike(Long exerciseId, UUID userId) {
        return exerciseRepository.findById(exerciseId)
                .map(exercise -> new LikeNumberResponseDTO(toggleLikeExercise(exercise, userId)))
                .orElseThrow(() -> new UnableToFindExerciseException(ErrorLocationType.PATH_PARAM, "id", exerciseId));
    }

    private Integer toggleLikeExercise(Exercise exercise, UUID userId) {
        return exerciseLikeRepository.findByExerciseIdAndUserId(exercise.getId(), userId)
                .map(like -> decrementLikeNumber(exercise, like))
                .orElseGet(() -> incrementLikeNumber(exercise, userId));
    }

    private Integer decrementLikeNumber(Exercise exercise, ExerciseLike like) {
        exerciseLikeRepository.delete(like);
        exerciseRepository.decrementLikesNumber(exercise.getId());
        return exercise.getLikesNumber() -1;
    }

    private Integer incrementLikeNumber(Exercise exercise, UUID userId) {
        ExerciseLike like = new ExerciseLike(exercise, userId);
        exerciseLikeRepository.save(like);
        exerciseRepository.incrementLikesNumber(exercise.getId());
        return exercise.getLikesNumber() + 1;
    }
}
