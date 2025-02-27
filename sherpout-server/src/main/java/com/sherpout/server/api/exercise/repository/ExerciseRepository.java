package com.sherpout.server.api.exercise.repository;

import com.sherpout.server.api.exercise.entity.Exercise;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface ExerciseRepository extends JpaRepository<Exercise, Long>, PagingAndSortingRepository<Exercise, Long> {
    @Modifying
    @Query("UPDATE Exercise e SET e.likesNumber = e.likesNumber + 1 WHERE e.id = :exerciseId")
    void incrementLikesNumber(@Param("exerciseId") Long exerciseId);

    @Modifying
    @Query("UPDATE Exercise e SET e.likesNumber = e.likesNumber - 1 WHERE e.id = :exerciseId")
    void decrementLikesNumber(@Param("exerciseId") Long exerciseId);
}
