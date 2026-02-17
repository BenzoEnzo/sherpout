package com.sherpout.server.commons.rate.limit;

import io.github.bucket4j.*;
import io.github.bucket4j.distributed.proxy.ProxyManager;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

import java.time.Duration;

@Component
@RequiredArgsConstructor
public class RateLimitRegistry {
    private final ProxyManager<String> proxyManager;

    public Bucket getOrCreate(RateLimitKey rateLimitKey, long requests, Duration duration) {
        return proxyManager.builder().build(rateLimitKey.getKey(), () -> createRateLimit(requests, duration));
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
