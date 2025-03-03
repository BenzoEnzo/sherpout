package com.sherpout.server.api.record.mapper;

import com.sherpout.server.api.exercise.mapper.ExerciseMapper;
import com.sherpout.server.api.record.dto.RecordDTO;
import com.sherpout.server.api.record.entity.Record;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(
        componentModel = "spring",
        uses = {
                ExerciseMapper.class,
        })
public interface RecordMapper {
        @Mapping(target = "exercise", source = "exercise",
                qualifiedByName = "mapToRecordExerciseDTO")
        RecordDTO mapToDTO(Record record);

        @Mapping(target = "id", ignore = true)
        Record mapToEntity(RecordDTO dto);
}
