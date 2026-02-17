package com.sherpout.server.api.training.execution.entity;

import com.sherpout.server.commons.enumerated.BaseEnum;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum TrainingExecutionStatus implements BaseEnum {
    IN_PROGRESS(1),
    FINISHED(2),
    CANCELLED(3);

    private final Integer id;
}
