package com.sherpout.server.commons.param;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;

@Getter
@Setter
public class DateRangeQueryParam {
    private LocalDate from;
    private LocalDate to;
}
