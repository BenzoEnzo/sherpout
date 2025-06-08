package com.sherpout.server.api.image.logic;

import com.sherpout.server.api.image.dto.ImageDTO;
import com.sherpout.server.api.image.dto.ImageUrlDTO;
import com.sherpout.server.error.exception.FileException;
import com.sherpout.server.error.model.ErrorMessage;
import io.minio.GetPresignedObjectUrlArgs;
import io.minio.MinioClient;
import io.minio.http.Method;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.util.concurrent.TimeUnit;

@Service
@RequiredArgsConstructor
public class ImageService {
    private final MinioClient minioClient;
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
}
