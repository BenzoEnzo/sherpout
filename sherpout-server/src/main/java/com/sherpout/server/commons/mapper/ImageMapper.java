package com.sherpout.server.commons.mapper;

import com.sherpout.server.commons.dto.ImageDTO;
import com.sherpout.server.commons.entity.Image;
import org.mapstruct.Mapper;

@Mapper(componentModel = "spring")
public interface ImageMapper {
    ImageDTO mapToDTO(Image image);
}
