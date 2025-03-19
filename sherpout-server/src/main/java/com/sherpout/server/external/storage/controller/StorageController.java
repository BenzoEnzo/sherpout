package com.sherpout.server.external.storage.controller;

import com.sherpout.server.commons.dto.ImageDTO;
import com.sherpout.server.config.security.group.SecuredByGroup;
import com.sherpout.server.config.security.group.UserGroup;
import com.sherpout.server.external.storage.logic.StorageService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

@RestController
@RequestMapping("storages")
@RequiredArgsConstructor
public class StorageController {

    private final StorageService storageService;

    @PostMapping
    @SecuredByGroup(UserGroup.USER)
    public ResponseEntity<Void> uploadFile(@RequestParam("file") MultipartFile file, @RequestBody ImageDTO dto) {
        storageService.uploadFile("sherpout",dto.getImagePath(),file);
        return ResponseEntity.ok().build();
    }
}
