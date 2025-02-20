package com.sherpout.server.commons.dto;

import com.sherpout.server.commons.validation.MaxFileSize;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ImageDTO {
    @MaxFileSize(10)
    private byte[] imageData;
}
