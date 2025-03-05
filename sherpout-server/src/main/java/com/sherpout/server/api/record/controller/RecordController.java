package com.sherpout.server.api.record.controller;

import com.sherpout.server.api.record.dto.RecordDTO;
import com.sherpout.server.api.record.logic.RecordService;
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
}
