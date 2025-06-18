package com.sherpout.server.api.record.mapper;

import com.sherpout.server.api.exercise.mapper.ExerciseMapper;
import com.sherpout.server.api.exercise.mapper.ExerciseMapperHelper;
import com.sherpout.server.api.record.dto.RecordDTO;
import com.sherpout.server.api.record.dto.RecordHistoryDTO;
import com.sherpout.server.api.record.entity.Record;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;

@Mapper(
        componentModel = "spring",
        uses = {
                ExerciseMapper.class,
                ExerciseMapperHelper.class,
        })
public interface RecordMapper {
    RecordDTO mapToDTO(Record record);

    RecordHistoryDTO mapToHistoryDTO(Record record);

    @Mapping(target = "id", ignore = true)
    @Mapping(target = "exercise", source = "exercise", qualifiedByName = "mapSelectToExercise")
    Record mapToEntity(RecordDTO dto);

    @Mapping(target = "id", ignore = true)
    @Mapping(target = "exercise", ignore = true)
    Record mapToUpdateEntity(RecordDTO dto, @MappingTarget Record record);
}
