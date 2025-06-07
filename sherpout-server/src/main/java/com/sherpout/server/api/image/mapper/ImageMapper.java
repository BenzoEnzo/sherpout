package com.sherpout.server.api.image.mapper;

import com.sherpout.server.api.image.dto.ImageDTO;
import com.sherpout.server.api.image.entity.Image;
import org.mapstruct.*;

@Mapper(componentModel = "spring")
public interface ImageMapper {
    @Mapping(target = "toDelete", source = "deprecated")
    ImageDTO mapToDTO(Image image);
    @Mapping(target = "deprecated", source = "toDelete")
    Image mapToEntity(ImageDTO dto);

    @Named("imageUpdate")
    @Mapping(target = "deprecated", source = "toDelete")
    @Mapping(target = "id", ignore = true)
    @BeanMapping(nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.IGNORE)
    Image mapToUpdateEntity(ImageDTO dto);
}
