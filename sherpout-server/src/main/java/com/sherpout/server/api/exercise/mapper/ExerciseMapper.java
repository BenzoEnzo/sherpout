package com.sherpout.server.api.exercise.mapper;

import com.sherpout.server.api.exercise.dto.ExerciseDTO;
import com.sherpout.server.api.exercise.dto.ExerciseListDTO;
import com.sherpout.server.api.exercise.dto.ExerciseSelectDTO;
import com.sherpout.server.api.exercise.entity.Exercise;
import com.sherpout.server.api.image.mapper.ImageMapper;
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
    @Mapping(target = "likesNumber", ignore = true)
    @BeanMapping(nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.IGNORE)
    @IterableMapping(qualifiedByName = "imageUpdate")
    void mapToUpdateEntity(ExerciseDTO dto, @MappingTarget Exercise exercise);

    @Mapping(target = "id", ignore = true)
    @Mapping(target = "likesNumber", ignore = true)
    @Mapping(target = "cover", ignore = true)
    @Mapping(target = "images", ignore = true)
    Exercise mapToEntity(ExerciseDTO dto);
}
