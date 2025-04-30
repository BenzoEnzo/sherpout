package com.sherpout.server.api.image.controller;

import com.sherpout.server.api.image.dto.ImageDTO;
import com.sherpout.server.api.image.logic.ImageService;
import com.sherpout.server.config.security.group.SecuredByGroup;
import com.sherpout.server.config.security.group.UserGroup;
import io.minio.errors.*;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;

@RestController
@RequestMapping("images")
@RequiredArgsConstructor
public class ImageController {
    private final ImageService imageService;

    @GetMapping("/url")
    @SecuredByGroup(UserGroup.USER)
    public ResponseEntity<ImageDTO> getImageUrl(
            @RequestParam String objectName) throws ServerException, InsufficientDataException, ErrorResponseException, IOException, NoSuchAlgorithmException, InvalidKeyException, InvalidResponseException, XmlParserException, InternalException {
        return ResponseEntity.ok(imageService.getImageUrl(objectName));
    }
}
