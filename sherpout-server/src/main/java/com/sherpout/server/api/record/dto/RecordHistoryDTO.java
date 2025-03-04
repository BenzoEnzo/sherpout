package com.sherpout.server.api.record.dto;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
public class RecordHistoryDTO {
    private Long id;
    private LocalDateTime time;
    private Integer value;
}
