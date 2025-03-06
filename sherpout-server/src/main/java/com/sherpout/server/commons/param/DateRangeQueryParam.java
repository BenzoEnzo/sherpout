package com.sherpout.server.commons.param;

import jakarta.validation.constraints.NotNull;
import lombok.Setter;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;

@Setter
public class DateRangeQueryParam {
    @NotNull
    private LocalDate from;

    @NotNull
    private LocalDate to;

    public LocalDateTime getFrom() {
        return from.atStartOfDay();
    }

    public LocalDateTime getTo() {
        return to.atTime(LocalTime.MAX);
    }
}
