package com.sherpout.server.api.record.controller;

import com.sherpout.server.api.record.dto.RecordDTO;
import com.sherpout.server.api.record.dto.RecordHistoryDTO;
import com.sherpout.server.api.record.logic.RecordService;
import com.sherpout.server.commons.param.DateRangeQueryParam;
import com.sherpout.server.config.security.group.SecuredByGroup;
import com.sherpout.server.config.security.group.UserGroup;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

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

    @GetMapping("history/{exerciseId}")
    @SecuredByGroup(UserGroup.USER)
    public ResponseEntity<List<RecordHistoryDTO>> getRecordHistory(@PathVariable Long exerciseId, @Valid DateRangeQueryParam dateRange) {
        return ResponseEntity
                .status(HttpStatus.OK)
                .body(recordService.getRecordHistory(exerciseId, dateRange));
    }

    @DeleteMapping("{id}")
    @SecuredByGroup(UserGroup.USER)
    public ResponseEntity<?> deleteRecord(@PathVariable Long id) {
        recordService.deleteRecord(id);
        return ResponseEntity
                .status(HttpStatus.NO_CONTENT)
                .build();
    }

    @GetMapping
    @SecuredByGroup(UserGroup.USER)
    public ResponseEntity<List<RecordDTO>> getRecords() {
        return ResponseEntity
                .status(HttpStatus.OK)
                .body(recordService.getRecords());
    }

    @PutMapping("/{id}")
    @SecuredByGroup(UserGroup.USER)
    public ResponseEntity<RecordDTO> updateRecord(@PathVariable Long id, @RequestBody RecordDTO request) {
        return ResponseEntity
                .status(HttpStatus.OK)
                .body(recordService.updateRecord(id, request));
    }
}
