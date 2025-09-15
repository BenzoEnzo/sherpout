package com.sherpout.server.api.training.dto;

import com.sherpout.server.commons.dto.TranslatedStringDTO;
import com.sherpout.server.commons.validation.TranslatedStringValid;
import jakarta.validation.Valid;
import jakarta.validation.constraints.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class TrainingPlanDTO {
    @Null
    private Long id;

    @NotNull
    @TranslatedStringValid
    private TranslatedStringDTO name;

    @TranslatedStringValid
    private TranslatedStringDTO description;

    @Valid
    @NotNull
    @NotEmpty
    @Size(min = 1, max = 7)
    private List<TrainingPlanDayDTO> days;

    private List<AssignedTrainingPlanDTO> assignments;
}
