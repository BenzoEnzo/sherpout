package com.sherpout.server.api.exercise.controller;

import com.sherpout.server.api.exercise.dto.ExerciseDTO;
import com.sherpout.server.api.exercise.dto.ExerciseListDTO;
import com.sherpout.server.api.exercise.dto.ExerciseSelectDTO;
import com.sherpout.server.api.exercise.dto.LikeNumberResponseDTO;
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
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@RestController
@RequestMapping("exercises")
@RequiredArgsConstructor
public class ExerciseController {
    private final TokenService tokenService;
    private final ExerciseService exerciseService;
    private final ExerciseLikeService exerciseLikeService;

    @PutMapping("/{id}")
    @SecuredByGroup(UserGroup.USER)
    public ResponseEntity<ExerciseDTO> updateExercise(
            @RequestPart("data") ExerciseDTO exerciseDTO,
            @PathVariable Long id,
            @RequestPart(value = "files", required = false) List<MultipartFile> files
    ) {
        return ResponseEntity
                .status(HttpStatus.OK)
                .body(exerciseService.updateExercise(exerciseDTO, id, files));
    }

    @PostMapping
    @SecuredByGroup(UserGroup.USER)
    public ResponseEntity<ExerciseDTO> createExercise(
            @Valid @RequestPart("data") ExerciseDTO exerciseDTO,
            @RequestPart(value = "files", required = false) List<MultipartFile> files
    ) {
        return ResponseEntity
                .status(HttpStatus.CREATED)
                .body(exerciseService.createExercise(exerciseDTO, files));
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
    public ResponseEntity<List<ExerciseListDTO>> getExercises() {
        return ResponseEntity
                .status(HttpStatus.OK)
                .body(exerciseService.getAllExercises());
    }

    @PutMapping("/{id}/toggle-like")
    @SecuredByGroup(UserGroup.USER)
    public ResponseEntity<LikeNumberResponseDTO> toggleLike(@PathVariable Long id) {
        return ResponseEntity
                .status(HttpStatus.OK)
                .body(exerciseLikeService.toggleLike(id, tokenService.getUserId()));
    }

    @GetMapping("/select")
    @SecuredByGroup(UserGroup.USER)
    public ResponseEntity<List<ExerciseSelectDTO>> getExerciseSelects() {
        return ResponseEntity
                .status(HttpStatus.OK)
                .body(exerciseService.getExerciseSelects());
    }
}
