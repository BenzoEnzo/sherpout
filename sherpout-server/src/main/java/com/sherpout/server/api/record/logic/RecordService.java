package com.sherpout.server.api.record.logic;

import com.sherpout.server.api.record.dto.RecordDTO;
import com.sherpout.server.api.record.entity.Record;
import com.sherpout.server.api.record.mapper.RecordMapper;
import com.sherpout.server.api.record.repository.RecordRepository;
import com.sherpout.server.api.user.logic.TokenService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class RecordService {
    private final TokenService tokenService;
    private final RecordRepository recordRepository;
    private final RecordMapper recordMapper;

    public RecordDTO createRecord(RecordDTO dto){
        Record record = recordMapper.mapToEntity(dto);
        record.setUserId(tokenService.getUser().getId());
        return recordMapper.mapToDTO(recordRepository.save(record));
    }

    public List<RecordDTO> getRecords(){
        return recordRepository.findBestAndLatestRecordsForUser(tokenService.getUser().getId())
                .stream()
                .map(recordMapper::mapToDTO)
                .toList();
    }
}
