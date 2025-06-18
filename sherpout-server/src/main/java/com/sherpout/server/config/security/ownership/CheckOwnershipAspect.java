package com.sherpout.server.config.security.ownership;

import com.sherpout.server.api.user.logic.TokenService;
import com.sherpout.server.error.exception.AccessForbiddenException;
import lombok.RequiredArgsConstructor;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.reflect.MethodSignature;
import org.springframework.stereotype.Component;

import java.lang.annotation.Annotation;
import java.lang.reflect.Method;
import java.util.Arrays;
import java.util.UUID;

@Aspect
@Component
@RequiredArgsConstructor
public class CheckOwnershipAspect {
    private final TokenService tokenService;

    @Around("@annotation(CheckOwnership)")
    public Object checkEntityOwnership(ProceedingJoinPoint joinPoint) throws Throwable {
        MethodSignature signature = (MethodSignature) joinPoint.getSignature();
        Method method = signature.getMethod();
        Object[] args = joinPoint.getArgs();
        Annotation[][] paramAnnotations = method.getParameterAnnotations();

        for (int i = 0; i < args.length; i++) {
            if (args[i] instanceof Ownable ownable && hasOwnershipCheck(paramAnnotations[i])) {
                UUID currentUserId = tokenService.getUserId();
                if (!currentUserId.equals(ownable.getUserId())) {
                    throw new AccessForbiddenException();
                }
            }
        }
        return joinPoint.proceed();
    }

    private boolean hasOwnershipCheck(Annotation[] annotations) {
        return Arrays.stream(annotations)
                .anyMatch(annotation -> annotation instanceof CheckOwnable);
    }
}
