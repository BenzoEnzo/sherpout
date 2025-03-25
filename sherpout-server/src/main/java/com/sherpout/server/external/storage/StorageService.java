package com.sherpout.server.external.storage;

import com.sherpout.server.commons.dto.ImageDTO;
import com.sherpout.server.error.exception.SingleApiErrorException;
import com.sherpout.server.error.model.ApiError;
import com.sherpout.server.error.model.ErrorLocationType;
import com.sherpout.server.error.model.ErrorMessage;
import io.minio.BucketExistsArgs;
import io.minio.MakeBucketArgs;
import io.minio.MinioClient;
import io.minio.PutObjectArgs;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
public class StorageService {
    private final MinioClient minioClient;

    @Value("${minio.bucket.name}")
    private String bucketName;

    public List<ImageDTO> uploadFiles(String dirName, List<MultipartFile> files) {
        List<ImageDTO> images = new ArrayList<>();

        for (MultipartFile mf : files) {
            String path = dirName.concat("/").concat(mf.getOriginalFilename());
            uploadFile(path, mf);
            ImageDTO img = new ImageDTO();
            img.setImagePath(path);
            images.add(img);
        }

        return images;
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
            throw new SingleApiErrorException(
                    ApiError.builder(ErrorMessage.INTERNAL_ERROR, HttpStatus.INTERNAL_SERVER_ERROR)
                            .withErrorLocationType(ErrorLocationType.FILE));
        }
    }
}
