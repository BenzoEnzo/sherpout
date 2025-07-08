package com.sherpout.server.api.training.controller;

import com.sherpout.server.api.training.dto.TrainingPlanDTO;
import com.sherpout.server.api.training.logic.TrainingPlanService;
import com.sherpout.server.config.security.group.SecuredByGroup;
import com.sherpout.server.config.security.group.UserGroup;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("training-plans")
@RequiredArgsConstructor
public class TrainingPlanController {
    private final TrainingPlanService trainingPlanService;

    @PostMapping
    @SecuredByGroup(UserGroup.USER)
    public ResponseEntity<TrainingPlanDTO> create(@Valid @RequestBody TrainingPlanDTO request) {
        return ResponseEntity
                .status(HttpStatus.CREATED)
                .body(trainingPlanService.create(request));
    }
}
