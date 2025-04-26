package com.sherpout.server.api.image.controller;

import com.sherpout.server.api.image.logic.ImageService;
import io.minio.errors.*;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.Collections;
import java.util.Map;

@RestController
@RequestMapping("/images")
@RequiredArgsConstructor
public class ImageController {
    private final ImageService imageService;

    @GetMapping("/url")
    public ResponseEntity<Map<String, String>> getImageUrl(
            @RequestParam String objectName) throws ServerException, InsufficientDataException, ErrorResponseException, IOException, NoSuchAlgorithmException, InvalidKeyException, InvalidResponseException, XmlParserException, InternalException {
        String url = imageService.getPresignedUrl(objectName);
        return ResponseEntity.ok(Collections.singletonMap("url", url));
    }
}
