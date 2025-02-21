package com.sherpout.server.api.exercise.repository;

import com.sherpout.server.api.exercise.entity.Exercise;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ExerciseRepository extends JpaRepository<Exercise, Long>, PagingAndSortingRepository<Exercise, Long> {

}
