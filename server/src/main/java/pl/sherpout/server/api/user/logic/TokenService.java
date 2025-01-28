package pl.sherpout.server.api.user.logic;

import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.security.oauth2.server.resource.authentication.JwtAuthenticationToken;
import org.springframework.stereotype.Service;
import pl.sherpout.server.api.user.dto.UserDto;

@Service
public class TokenService {
    public UserDto getUser(JwtAuthenticationToken auth) {
        return new UserDto();
    }

    public String getUUID(JwtAuthenticationToken auth) {
        Jwt jwt = (Jwt) auth.getPrincipal();
        return jwt.getClaim("uuid");
    }
}
