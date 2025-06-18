package com.sherpout.server.config.security.ownership;

import com.sherpout.server.api.user.logic.TokenService;
import com.sherpout.server.error.exception.AccessForbiddenException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

import java.util.UUID;

@Component
@RequiredArgsConstructor
public class OwnershipGuard {
    private final TokenService tokenService;

    public void checkOwnership(Ownable ownable) {
        UUID currentUserId = tokenService.getUserId();
        if (!ownable.getUserId().equals(currentUserId)) {
            throw new AccessForbiddenException();
        }
    }
}
