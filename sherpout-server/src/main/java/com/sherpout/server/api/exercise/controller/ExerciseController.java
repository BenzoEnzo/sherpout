package com.sherpout.server.api.exercise.controller;

import com.sherpout.server.api.exercise.dto.ExerciseDTO;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("exercise")
public class ExerciseController {
    @PostMapping
    public ResponseEntity<ExerciseDTO> createExercise(ExerciseDTO exerciseDTO) {
        return ResponseEntity
                .status(HttpStatus.CREATED)
                .body(null);
    }
}
