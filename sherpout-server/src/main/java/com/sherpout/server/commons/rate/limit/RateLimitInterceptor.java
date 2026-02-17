package com.sherpout.server.commons.rate.limit;

import com.sherpout.server.api.user.logic.TokenService;
import com.sherpout.server.error.exception.TooManyRequestException;
import io.github.bucket4j.Bucket;
import io.github.bucket4j.ConsumptionProbe;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.core.annotation.AnnotatedElementUtils;
import org.springframework.stereotype.Component;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerInterceptor;

import java.time.Duration;

@Component
@RequiredArgsConstructor
public class RateLimitInterceptor implements HandlerInterceptor {
    private final static int TOKEN_PER_REQUEST = 1;
    private final RateLimitRegistry rateLimitRegistry;
    private final TokenService tokenService;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) {
        if (!(handler instanceof HandlerMethod handlerMethod)) return true;

        RateLimit rateLimit = resolveRateLimit(handlerMethod);

        if (rateLimit == null) return true;

        RateLimitKey key = new RateLimitKey(handlerMethod.getMethod().toGenericString(),
                tokenService.getUserId().toString());

        Duration duration = Duration.ofMillis(rateLimit.unit().toMillis(rateLimit.duration()));
        Bucket bucket = rateLimitRegistry.getOrCreate(key, rateLimit.requests(), duration);

        ConsumptionProbe probe = bucket.tryConsumeAndReturnRemaining(TOKEN_PER_REQUEST);

        if (probe.isConsumed()) {
            return true;
        }

        throw new TooManyRequestException();
    }

    private RateLimit resolveRateLimit(HandlerMethod handlerMethod) {
        return AnnotatedElementUtils.findMergedAnnotation(
                handlerMethod.getMethod(), RateLimit.class
        );
    }
}

