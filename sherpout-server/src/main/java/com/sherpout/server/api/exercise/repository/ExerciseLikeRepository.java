package com.sherpout.server.api.exercise.repository;

import com.sherpout.server.api.exercise.entity.ExerciseLike;
import com.sherpout.server.api.exercise.entity.ExerciseLikeId;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;
import java.util.UUID;

@Repository
public interface ExerciseLikeRepository extends JpaRepository<ExerciseLike, ExerciseLikeId> {
    Optional<ExerciseLike> findByExerciseIdAndUserId(Long exerciseId, UUID userId);
}
