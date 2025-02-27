package com.sherpout.server.commons.dto.pagination;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PaginationDTO {
    private Integer page;
    private Integer size;
}
