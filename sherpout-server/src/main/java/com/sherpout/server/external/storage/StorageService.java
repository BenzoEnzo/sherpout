package com.sherpout.server.external.storage;

import com.sherpout.server.commons.entity.Image;
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

@Service
@RequiredArgsConstructor
public class StorageService {
    private final MinioClient minioClient;

    @Value("${minio.bucket.name}")
    private String bucketName;

    public List<Image> uploadFiles(String dirName, List<MultipartFile> files) {
        return files.stream()
                .map(mf -> {
                    String path = dirName + "/" + mf.getOriginalFilename();
                    uploadFile(path, mf);
                    Image img = new Image();
                    img.setImagePath(path);
                    return img;
                })
                .toList();
    }

    private void uploadFile(String objectName, MultipartFile file) {
        try {
            boolean found = minioClient.bucketExists(BucketExistsArgs.builder().bucket(bucketName).build());
            if (!found) {
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
