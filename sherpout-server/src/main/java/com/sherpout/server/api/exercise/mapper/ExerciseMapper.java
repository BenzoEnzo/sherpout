package com.sherpout.server.api.exercise.mapper;

import com.sherpout.server.api.exercise.dto.ExerciseDTO;
import com.sherpout.server.api.exercise.dto.ExerciseListDTO;
import com.sherpout.server.api.exercise.dto.ExerciseSelectDTO;
import com.sherpout.server.api.exercise.entity.Exercise;
import com.sherpout.server.commons.mapper.ImageMapper;
import com.sherpout.server.commons.mapper.TranslatedStringMapper;
import org.mapstruct.*;

@Mapper(
        componentModel = "spring",
        uses = {
                TranslatedStringMapper.class,
                ImageMapper.class
        })
public interface ExerciseMapper {
    ExerciseDTO mapToDTO(Exercise exercise);

    ExerciseListDTO mapToListDTO(Exercise exercise);

    ExerciseSelectDTO mapToSelectDTO(Exercise exercise);

    @Mapping(target = "id", ignore = true)
    @BeanMapping(nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.IGNORE)
    void mapToUpdateEntity(ExerciseDTO dto, @MappingTarget Exercise exercise);

    @Mapping(target = "id", ignore = true)
    Exercise mapToEntity(ExerciseDTO dto);
}
