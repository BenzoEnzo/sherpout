package com.sherpout.server.api.image.controller;

import com.sherpout.server.api.image.dto.ImageDTO;
import com.sherpout.server.api.image.logic.ImageService;
import com.sherpout.server.config.security.group.SecuredByGroup;
import com.sherpout.server.config.security.group.UserGroup;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("images")
@RequiredArgsConstructor
public class ImageController {
    private final ImageService imageService;

    @GetMapping("/url")
    @SecuredByGroup(UserGroup.USER)
    public ResponseEntity<ImageDTO> getImageUrl(@RequestParam String objectName) {
        return ResponseEntity.ok(imageService.getImageFromBucket(objectName));
    }
}
