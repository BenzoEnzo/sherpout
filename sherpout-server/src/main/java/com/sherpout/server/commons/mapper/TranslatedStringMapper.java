package com.sherpout.server.commons.mapper;

import com.sherpout.server.commons.dto.TranslatedStringDTO;
import com.sherpout.server.commons.entity.TranslatedString;
import org.mapstruct.Mapper;

@Mapper(componentModel = "spring")
public interface TranslatedStringMapper {
    TranslatedStringDTO mapToDTO(TranslatedString entity);

    TranslatedString mapToEntity(TranslatedStringDTO dto);
}
