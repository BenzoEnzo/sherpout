package com.sherpout.server.api.training.controller;

import com.sherpout.server.api.training.dto.TrainingPlanDTO;
import com.sherpout.server.api.training.logic.TrainingPlanService;
import com.sherpout.server.config.security.group.SecuredByGroup;
import com.sherpout.server.config.security.group.UserGroup;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;

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

    @PatchMapping("/{id}/assign")
    @SecuredByGroup(UserGroup.TRAINER)
    public ResponseEntity<TrainingPlanDTO> assignTrainingPlan(@PathVariable Long id, @RequestParam UUID userId) {
        return ResponseEntity
                .status(HttpStatus.OK)
                .body(trainingPlanService.assignToUser(userId,id));
    }
}
