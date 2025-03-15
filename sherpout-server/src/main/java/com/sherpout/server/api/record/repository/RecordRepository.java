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
    @Query("""
            SELECT r
            FROM Record r
            WHERE r.userId = :userId
              AND r.value = (
                SELECT MAX(r2.value)
                FROM Record r2
                WHERE r2.exercise.id = r.exercise.id
                  AND r2.userId = :userId
              )
              AND r.date = (
                SELECT MAX(r3.date)
                FROM Record r3
                WHERE r3.userId = :userId
                  AND r3.exercise.id = r.exercise.id
                  AND r3.value = (
                    SELECT MAX(r4.value)
                    FROM Record r4
                    WHERE r4.exercise.id = r3.exercise.id
                      AND r4.userId = :userId
                  )
              )
            """)
    List<Record> findBestAndLatestRecordsForUser(@Param("userId") UUID userId);
}