package ${config.domain}.${config.groupId}.${config.projectName}.config;

import io.minio.BucketExistsArgs;
import io.minio.MakeBucketArgs;
import io.minio.MinioClient;
import io.minio.SetBucketVersioningArgs;
import io.minio.errors.ErrorResponseException;
import io.minio.errors.InsufficientDataException;
import io.minio.errors.InternalException;
import io.minio.errors.InvalidResponseException;
import io.minio.errors.ServerException;
import io.minio.errors.XmlParserException;
import io.minio.messages.VersioningConfiguration;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.io.IOException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;

@Configuration
public class MinioConfig {

<#noparse>@Value("${minio.endpoint}")</#noparse>
    private String endpoint;

<#noparse>@Value("${minio.accessKey}")</#noparse>
    private String accessKey;

<#noparse>@Value("${minio.secretKey}")</#noparse>
    private String secretKey;
<#noparse>@Value("${minio.default.bucket}")</#noparse>
    private String bucketName;

    private void createBucketIfNotExists(MinioClient minioClient) {
        try {
            boolean bucketExists = minioClient.bucketExists(BucketExistsArgs.builder().bucket(bucketName.toLowerCase()).build());
            if(StringUtils.isNotEmpty(bucketName) && ! bucketExists ){
                minioClient.makeBucket(MakeBucketArgs.builder().bucket(bucketName.toLowerCase()).build());
                VersioningConfiguration config = new VersioningConfiguration(VersioningConfiguration.Status.ENABLED, false);
                minioClient.setBucketVersioning(
                        SetBucketVersioningArgs.builder().bucket(bucketName.toLowerCase()).config(config).build());
            }
        }catch (Exception e){
            e.getStackTrace();
        }

    }

    @Bean
    public MinioClient minioClient(){
        MinioClient minioClient = MinioClient.builder()
                .endpoint(endpoint)
                .credentials(accessKey, secretKey)
                .build();
        createBucketIfNotExists(minioClient);
        return minioClient;
    }
}
