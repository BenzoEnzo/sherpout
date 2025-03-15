package com.sherpout.server.api.record.repository;

import com.sherpout.server.api.record.entity.Record;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

@Repository
public interface RecordRepository extends JpaRepository<Record, Long> {
    @Query(value = """
              SELECT DISTINCT ON (r.exercise_id)
                       r.id             AS id,
                       r.user_id        AS user_id,
                       r.exercise_id    AS exercise_id,
                       r.value          AS value,
                       r.date           AS date
                FROM record r
                WHERE r.user_id = :userId
                ORDER BY r.exercise_id, r.value DESC, r.date DESC
        """, nativeQuery = true)
    List<Record> findBestAndLatestRecordsForUser(@Param("userId") UUID userId);
}