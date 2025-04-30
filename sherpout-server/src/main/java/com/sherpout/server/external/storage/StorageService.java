package com.sherpout.server.external.storage;

import com.sherpout.server.api.image.entity.Image;
import com.sherpout.server.error.exception.FileException;
import com.sherpout.server.error.model.ErrorMessage;
import io.minio.BucketExistsArgs;
import io.minio.MakeBucketArgs;
import io.minio.MinioClient;
import io.minio.PutObjectArgs;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class StorageService {
    private final MinioClient minioClient;

    @Value("${minio.bucket.name}")
    private String bucketName;

    public List<Image> uploadFiles(String dirName, List<MultipartFile> files) {
        return files.stream().map(file -> transformFileToImage(dirName,file)).toList();
    }

    private Image transformFileToImage(String dirName, MultipartFile file){
        String fileName = file.getOriginalFilename();
        String path = dirName + "/" + UUID.randomUUID() + fileName.substring(fileName.lastIndexOf('.'));
        uploadFile(path, file);
        Image img = new Image();
        img.setImagePath(path);
        return img;
    }

    private void uploadFile(String objectName, MultipartFile file) {
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
