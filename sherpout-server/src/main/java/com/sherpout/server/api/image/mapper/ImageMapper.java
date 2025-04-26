package com.sherpout.server.api.image.mapper;

import com.sherpout.server.api.image.dto.ImageDTO;
import com.sherpout.server.api.image.entity.Image;
import org.mapstruct.Mapper;

@Mapper(componentModel = "spring")
public interface ImageMapper {
    ImageDTO mapToDTO(Image image);
}
