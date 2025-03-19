package com.sherpout.server.api.record.logic;

import com.sherpout.server.api.exercise.entity.Exercise;
import com.sherpout.server.api.exercise.repository.ExerciseRepository;
import com.sherpout.server.api.record.dto.RecordDTO;
import com.sherpout.server.api.record.dto.RecordHistoryDTO;
import com.sherpout.server.api.record.entity.Record;
import com.sherpout.server.api.record.mapper.RecordMapper;
import com.sherpout.server.api.record.repository.RecordRepository;
import com.sherpout.server.api.user.logic.TokenService;
import com.sherpout.server.commons.param.DateRangeQueryParam;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
@RequiredArgsConstructor
public class RecordService {
    private final TokenService tokenService;
    private final RecordRepository recordRepository;
    private final ExerciseRepository exerciseRepository;
    private final RecordMapper recordMapper;

    public RecordDTO createRecord(RecordDTO dto) {
        Record record = recordMapper.mapToEntity(dto);
        record.setUserId(tokenService.getUser().getId());
        return recordMapper.mapToDTO(recordRepository.save(record));
    }

    public List<RecordHistoryDTO> getRecordHistory(Long exerciseId, DateRangeQueryParam dateRange) {
        return exerciseRepository.findById(exerciseId)
                .map(exercise -> getRecordHistoryBetweenDates(exercise, dateRange.getFrom(), dateRange.getTo()))
                .orElseThrow(IllegalArgumentException::new);
    }

    private List<RecordHistoryDTO> getRecordHistoryBetweenDates(Exercise exercise, LocalDateTime from, LocalDateTime to) {
        return recordRepository.findAllByExerciseAndDateBetweenOrderByDateDesc(exercise, from, to).stream()
                .map(recordMapper::mapToHistoryDTO)
                .toList();
    }

    public void deleteRecord(Long id) {
        Record record = recordRepository.findById(id).orElseThrow(IllegalArgumentException::new);
        if (record.getUserId().equals(tokenService.getUser().getId())) {
            recordRepository.delete(record);
        } else {
            throw new IllegalArgumentException();
        }
    }
}
