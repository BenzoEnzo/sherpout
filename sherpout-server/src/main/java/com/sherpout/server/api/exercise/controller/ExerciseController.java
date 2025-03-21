package com.sherpout.server.api.exercise.controller;

import com.sherpout.server.api.exercise.dto.ExerciseDTO;
import com.sherpout.server.api.exercise.dto.ExerciseListDTO;
import com.sherpout.server.api.exercise.dto.LikeNumberResponseDTO;
import com.sherpout.server.api.exercise.enumerated.MuscleCategory;
import com.sherpout.server.api.exercise.logic.ExerciseLikeService;
import com.sherpout.server.api.exercise.logic.ExerciseService;
import com.sherpout.server.api.user.logic.TokenService;
import com.sherpout.server.config.security.group.SecuredByGroup;
import com.sherpout.server.config.security.group.UserGroup;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("exercises")
@RequiredArgsConstructor
public class ExerciseController {
    private final TokenService tokenService;
    private final ExerciseService exerciseService;
    private final ExerciseLikeService exerciseLikeService;

    @PutMapping("/{id}")
    @SecuredByGroup(UserGroup.USER)
    public ResponseEntity<ExerciseDTO> updateExercise(@RequestBody ExerciseDTO exerciseDTO, @PathVariable Long id) {
        return ResponseEntity
                .status(HttpStatus.OK)
                .body(exerciseService.updateExercise(exerciseDTO, id));
    }

    @PostMapping
    @SecuredByGroup(UserGroup.USER)
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
    public ResponseEntity<Map<MuscleCategory, List<ExerciseListDTO>>> getExercises() {
        return ResponseEntity
                .status(HttpStatus.OK)
                .body(exerciseService.getAllExercises());
    }

    @PutMapping("/{id}/toggle-like")
    @SecuredByGroup(UserGroup.USER)
    public ResponseEntity<LikeNumberResponseDTO> toggleLike(@PathVariable Long id) {
        return ResponseEntity
                .status(HttpStatus.OK)
                .body(exerciseLikeService.toggleLike(id, tokenService.getUser().getId()));
    }
}
