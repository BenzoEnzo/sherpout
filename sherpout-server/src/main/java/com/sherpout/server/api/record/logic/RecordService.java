package com.sherpout.server.api.record.logic;

import com.sherpout.server.api.record.dto.RecordDTO;
import com.sherpout.server.api.record.entity.Record;
import com.sherpout.server.api.record.mapper.RecordMapper;
import com.sherpout.server.api.record.repository.RecordRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class RecordService {
    private final RecordRepository recordRepository;
    private final RecordMapper recordMapper;

    public RecordDTO createRecord(RecordDTO dto){
        Record record = recordRepository.save(recordMapper.mapToEntity(dto));
        return recordMapper.mapToDTO(record);
    }
}
