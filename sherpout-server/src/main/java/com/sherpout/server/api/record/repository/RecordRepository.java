package com.sherpout.server.api.record.repository;

import com.sherpout.server.api.exercise.entity.Exercise;
import com.sherpout.server.api.record.entity.Record;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface RecordRepository extends JpaRepository<Record, Long> {
    List<Record> findAllByExerciseAndDateBetweenOrderByDateDesc(Exercise exercise, LocalDateTime start, LocalDateTime end);
}
