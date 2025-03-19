package com.sherpout.server.api.record.dto;

import java.time.LocalDateTime;

public record RecordHistoryDTO(Long id, LocalDateTime date, Integer value) { }
