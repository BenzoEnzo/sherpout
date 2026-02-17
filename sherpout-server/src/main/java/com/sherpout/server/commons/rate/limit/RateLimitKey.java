package com.sherpout.server.commons.rate.limit;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
public class RateLimitKey {
    private final String endpoint;
    private final String userId;

    public String getKey() {
        return "rl:" + this.endpoint + ":" + this.userId;
    }
}
