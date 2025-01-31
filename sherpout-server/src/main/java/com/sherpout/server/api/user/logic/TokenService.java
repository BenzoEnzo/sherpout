package com.sherpout.server.api.user.logic;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.oauth2.server.resource.authentication.JwtAuthenticationToken;
import org.springframework.stereotype.Service;
import com.sherpout.server.api.user.dto.UserDto;
import com.sherpout.server.config.security.group.UserGroup;

@Service
public class TokenService {
    public UserDto getUser(JwtAuthenticationToken auth) {
        UserDto user = new UserDto();
        user.setGroup(getGroup(auth));
        user.setFirstName(getClaim(auth, "given_name"));
        user.setLastName(getClaim(auth, "family_name"));
        user.setEmail(getClaim(auth, "email"));
        user.setEmailVerified(getClaim(auth, "email_verified"));
        return user;
    }

    private UserGroup getGroup(JwtAuthenticationToken auth) {
        GrantedAuthority authority = auth.getAuthorities().stream()
                .findFirst()
                .orElseThrow(IllegalArgumentException::new);
        return UserGroup.valueOf(authority.getAuthority());
    }

    private <T> T getClaim(JwtAuthenticationToken auth, String claim) {
        return auth.getToken().getClaim(claim);
    }
}
