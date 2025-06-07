package com.sherpout.server.external.storage;

import com.sherpout.server.error.exception.FileException;
import com.sherpout.server.error.model.ErrorMessage;
import io.minio.*;
import io.minio.http.Method;
import io.minio.messages.DeleteError;
import io.minio.messages.DeleteObject;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.UUID;
import java.util.concurrent.TimeUnit;

@Service
@RequiredArgsConstructor
@Slf4j
public class StorageService {
    private final MinioClient minioClient;

    @Value("${minio.bucket.name}")
    private String bucketName;

    public void deleteFiles(List<String> objectNames) {
        Iterable<Result<DeleteError>> results = removeObjects(objectNames.stream()
                .map(DeleteObject::new)
                .toList());

        results.forEach(result -> {
            try {
                result.get();
            } catch (Exception e) {
                throw new FileException(ErrorMessage.IMAGE_DELETE_ERROR, e.getMessage());
            }
        });
    }

    private Iterable<Result<DeleteError>> removeObjects(List<DeleteObject> objects) {
        return minioClient.removeObjects(
                RemoveObjectsArgs.builder()
                        .bucket(bucketName)
                        .objects(objects)
                        .build());
    }

    public String getPresignedUrl(String name) {
        try {
            return minioClient.getPresignedObjectUrl(
                    GetPresignedObjectUrlArgs.builder()
                            .method(Method.GET)
                            .bucket(bucketName)
                            .object(name)
                            .expiry(15, TimeUnit.MINUTES)
                            .build());
        } catch (Exception e) {
            throw new FileException(ErrorMessage.IMAGE_FETCH_ERROR, name);
        }
    }

    public void uploadFile(String objectName, MultipartFile file) {
        try {
            if (!minioClient.bucketExists(BucketExistsArgs.builder().bucket(bucketName).build())) {
                minioClient.makeBucket(MakeBucketArgs.builder().bucket(bucketName).build());
            }
            minioClient.putObject(
                    PutObjectArgs.builder().bucket(bucketName).object(objectName).stream(
                                    file.getInputStream(), file.getInputStream().available(), -1)
                            .contentType(file.getContentType())
                            .build());
        } catch (Exception e) {
            throw new FileException(ErrorMessage.FILE_STORAGE_ERROR);
        }
    }
}
