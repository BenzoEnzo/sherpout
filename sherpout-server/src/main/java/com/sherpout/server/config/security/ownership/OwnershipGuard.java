package com.sherpout.server.config.security.ownership;

import com.sherpout.server.api.user.dto.UserDto;
import com.sherpout.server.api.user.logic.TokenService;
import com.sherpout.server.config.security.group.UserGroup;
import com.sherpout.server.error.exception.AccessForbiddenException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class OwnershipGuard {
    private final TokenService tokenService;

    public void checkOwnership(Ownable ownable) {
        UserDto user = tokenService.getUser();
        if (!ownable.getUserId().equals(user.getId()) && !user.getGroup().equals(UserGroup.ADMIN)) {
            throw new AccessForbiddenException();
        }
    }
}
