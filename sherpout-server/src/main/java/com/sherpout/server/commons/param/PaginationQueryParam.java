package com.sherpout.server.commons.param;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PaginationQueryParam {
    private Integer page;
    private Integer size;
}
