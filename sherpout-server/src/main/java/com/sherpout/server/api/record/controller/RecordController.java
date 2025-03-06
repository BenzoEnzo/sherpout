package com.sherpout.server.api.record.controller;

import com.sherpout.server.api.record.dto.RecordDTO;
import com.sherpout.server.api.record.logic.RecordService;
import com.sherpout.server.config.security.group.SecuredByGroup;
import com.sherpout.server.config.security.group.UserGroup;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("records")
@RequiredArgsConstructor
public class RecordController {
    private final RecordService recordService;

    @PostMapping
    @SecuredByGroup(UserGroup.USER)
    public ResponseEntity<RecordDTO> createRecord(@Valid @RequestBody RecordDTO request) {
        return ResponseEntity
                .status(HttpStatus.CREATED)
                .body(recordService.createRecord(request));
    }

    @DeleteMapping("{id}")
    @SecuredByGroup(UserGroup.USER)
    public ResponseEntity<?> deleteRecord(@PathVariable Long id) {
        return ResponseEntity
                .status(HttpStatus.NO_CONTENT)
                .body(null);
    }
}
