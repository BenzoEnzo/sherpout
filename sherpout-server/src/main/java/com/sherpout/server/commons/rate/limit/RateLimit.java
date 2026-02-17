package com.sherpout.server.commons.rate.limit;

import java.lang.annotation.*;
import java.util.concurrent.TimeUnit;

@Target({ElementType.METHOD, ElementType.TYPE})
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface RateLimit {
    long requests();
    long duration();
    TimeUnit unit() default TimeUnit.MINUTES;
}

