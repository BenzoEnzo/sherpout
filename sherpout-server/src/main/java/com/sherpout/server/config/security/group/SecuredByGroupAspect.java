package com.sherpout.server.config.security.group;

import com.sherpout.server.error.exception.SecurityByGroupException;
import com.sherpout.server.error.model.ApiError;
import com.sherpout.server.error.model.ErrorLocationType;
import com.sherpout.server.error.model.ErrorMessage;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;

@Aspect
@Component
public class SecuredByGroupAspect {

    @Around("@annotation(securedByGroup)")
    public Object checkAuthorization(ProceedingJoinPoint joinPoint, SecuredByGroup securedByGroup) throws Throwable {
        ApiError apiError = ApiError.builder()
                .errorLocationType(ErrorLocationType.PATH_PARAM)
                .errorMessage(ErrorMessage.UNAUTHORIZED)
                .build();

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

        if (authentication == null || !authentication.isAuthenticated()) {
            throw new SecurityByGroupException(apiError);
        }

        Integer userAccessLevel = authentication.getAuthorities().stream()
                .map(authority -> UserGroup.valueOf(authority.getAuthority()).getAccessLevel())
                .findFirst()
                .orElse(UserGroup.DEFAULT.getAccessLevel());

        if (securedByGroup.value().getAccessLevel() > userAccessLevel) {
            throw new SecurityByGroupException(apiError);
        }

        return joinPoint.proceed();
    }

}
