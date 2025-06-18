package com.sherpout.server.api.image.logic;

import com.sherpout.server.api.exercise.dto.ExerciseDTO;
import com.sherpout.server.api.image.dto.ImageDTO;
import com.sherpout.server.api.image.dto.ImageUrlDTO;
import com.sherpout.server.api.image.entity.Image;
import com.sherpout.server.api.image.mapper.ImageMapper;
import com.sherpout.server.api.image.repository.ImageRepository;
import com.sherpout.server.external.storage.StorageService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class ImageService {
    private final StorageService storageService;
    private final ImageMapper imageMapper;
    private final ImageRepository imageRepository;

    public ImageUrlDTO getPresignedUrlByName(String name) {
        return new ImageUrlDTO(storageService.getPresignedUrl(name));
    }

    public void deleteImagesFromBucket(ExerciseDTO exerciseDTO) {
        List<ImageDTO> imagesToDelete = exerciseDTO.getImages().stream()
                .filter(img -> img.getToDelete().equals(true))
                .toList();
        deleteImagesFromDatabase(imagesToDelete);
        storageService.deleteFiles(imagesToDelete);

    }

    private void deleteImagesFromDatabase(List<ImageDTO> imagesToDelete){
        imageRepository.deleteAll(transformDtosToEntities(imagesToDelete));
    }

    private List<Image> transformDtosToEntities(List<ImageDTO> imageDTOS){
        return imageDTOS.stream().map(imageMapper::mapToEntity).toList();
    }

    public List<Image> convertAndSaveImages(String dirName, List<MultipartFile> files) {
        return files.stream().map(file -> transformFileToImage(dirName, file)).toList();
    }

    private Image transformFileToImage(String dirName, MultipartFile file) {
        String fileName = file.getOriginalFilename();
        String fullName = dirName + "/" + UUID.randomUUID() + fileName.substring(fileName.lastIndexOf('.'));
        storageService.uploadFile(fullName, file);
        Image img = new Image();
        img.setName(fullName);
        return img;
    }
}
