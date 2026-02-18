package com.sherpout.server.commons.rate.limit;

import com.sherpout.server.external.redis.RedisDataKey;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
public class RateLimitKey implements RedisDataKey {
    private final String endpoint;
    private final String userId;

    @Override
    public String toTextKey() {
        return "rl:" + this.endpoint + ":" + this.userId;
    }
}
