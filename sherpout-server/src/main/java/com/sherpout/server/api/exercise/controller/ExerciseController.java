package com.sherpout.server.api.exercise.controller;

import com.sherpout.server.api.exercise.dto.ExerciseDTO;
import com.sherpout.server.api.exercise.dto.ExerciseListDTO;
import com.sherpout.server.api.exercise.logic.ExerciseService;
import com.sherpout.server.commons.dto.pagination.PageResponseDTO;
import com.sherpout.server.commons.dto.pagination.PaginationDTO;
import com.sherpout.server.config.security.group.SecuredByGroup;
import com.sherpout.server.config.security.group.UserGroup;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("exercises")
@RequiredArgsConstructor
public class ExerciseController {
    private final ExerciseService exerciseService;

    @PostMapping
    @SecuredByGroup(UserGroup.TRAINER)
    public ResponseEntity<ExerciseDTO> createExercise(@Valid @RequestBody ExerciseDTO exerciseDTO) {
        return ResponseEntity
                .status(HttpStatus.CREATED)
                .body(exerciseService.createExercise(exerciseDTO));
    }

    @GetMapping("/{id}")
    @SecuredByGroup(UserGroup.USER)
    public ResponseEntity<ExerciseDTO> getExerciseById(@PathVariable Long id) {
        return ResponseEntity
                .status(HttpStatus.OK)
                .body(exerciseService.getExerciseById(id));
    }

    @GetMapping
    @SecuredByGroup(UserGroup.USER)
    public ResponseEntity<PageResponseDTO<ExerciseListDTO>> getExercises(PaginationDTO pagination) {
        return ResponseEntity
                .status(HttpStatus.OK)
                .body(exerciseService.getAllExercises(pagination));
    }
}
