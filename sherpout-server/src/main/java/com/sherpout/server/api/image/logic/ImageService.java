package com.sherpout.server.api.image.logic;

import com.sherpout.server.api.image.dto.ImageDTO;
import com.sherpout.server.api.image.dto.ImageUrlDTO;
import com.sherpout.server.error.exception.FileException;
import com.sherpout.server.error.model.ErrorMessage;
import com.sherpout.server.external.storage.StorageService;
import io.minio.GetPresignedObjectUrlArgs;
import io.minio.MinioClient;
import io.minio.http.Method;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.util.LinkedList;
import java.util.List;
import java.util.concurrent.TimeUnit;

@Service
@RequiredArgsConstructor
public class ImageService {
    private final MinioClient minioClient;
    private final StorageService storageService;
    @Value("${minio.bucket.name}")
    private String bucketName;

    public ImageUrlDTO getPresignedUrlByName(String name) {
        try {
            return new ImageUrlDTO(minioClient.getPresignedObjectUrl(
                    GetPresignedObjectUrlArgs.builder()
                            .method(Method.GET)
                            .bucket(bucketName)
                            .object(name)
                            .expiry(15, TimeUnit.MINUTES)
                            .build()));
        } catch(Exception e) {
            throw new FileException(ErrorMessage.IMAGE_FETCH_ERROR, name);
        }
    }

    public List<ImageDTO> deleteImagesFromBucket(List<ImageDTO> images) {
        List<ImageDTO> imagesToDelete = new LinkedList<>();
        if (!images.isEmpty()) {
            images.stream()
                    .filter(ImageDTO::isToDelete)
                    .forEach(image -> {
                        storageService.deleteFile(image.getImagePath());
                        imagesToDelete.add(image);
                    });
        }

        return imagesToDelete;
    }
}
