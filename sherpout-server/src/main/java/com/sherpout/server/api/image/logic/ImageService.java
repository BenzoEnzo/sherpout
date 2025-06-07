package com.sherpout.server.api.image.logic;

import com.sherpout.server.api.exercise.dto.ExerciseDTO;
import com.sherpout.server.api.image.dto.ImageDTO;
import com.sherpout.server.api.image.dto.ImageUrlDTO;
import com.sherpout.server.external.storage.StorageService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class ImageService {
    private final StorageService storageService;

    public ImageUrlDTO getPresignedUrlByName(String name) {
        return new ImageUrlDTO(storageService.getPresignedUrl(name));
    }

    public void deleteImagesFromBucket(ExerciseDTO exerciseDTO) {
        storageService.deleteFiles(exerciseDTO.getImages().stream()
                .filter(img -> img.getToDelete().equals(true))
                .map(ImageDTO::getName)
                .toList());
    }
}
