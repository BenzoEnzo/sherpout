package com.sherpout.server.commons.rate.limit;

import com.sherpout.server.external.redis.RedisDataKey;
import io.github.bucket4j.*;
import io.github.bucket4j.distributed.proxy.ProxyManager;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

import java.time.Duration;

@Component
@RequiredArgsConstructor
public class RateLimitRegistry {
    private final ProxyManager<String> proxyManager;

    public Bucket getOrCreate(RedisDataKey redisDataKey, long requests, Duration duration) {
        return proxyManager.builder().build(redisDataKey.toTextKey(), () -> createRateLimit(requests, duration));
    }

    private BucketConfiguration createRateLimit(long requests, Duration duration) {
        Bandwidth limit = Bandwidth.builder()
                .capacity(requests)
                .refillIntervally(requests, duration)
                .build();
        return BucketConfiguration.builder()
                .addLimit(limit)
                .build();
    }
}
