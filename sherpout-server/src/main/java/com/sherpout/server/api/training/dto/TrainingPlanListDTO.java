package com.sherpout.server.api.training.dto;

import com.sherpout.server.commons.dto.TranslatedStringDTO;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;

@Getter
@Setter
public class TrainingPlanListDTO {
    private Long id;
    private TranslatedStringDTO name;
    private Integer setsNumber;
    private LocalDate lastUsed;
}
