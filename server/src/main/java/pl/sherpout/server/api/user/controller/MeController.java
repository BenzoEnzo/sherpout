package pl.sherpout.server.api.user.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.oauth2.server.resource.authentication.JwtAuthenticationToken;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import pl.sherpout.server.api.user.dto.UserDto;
import pl.sherpout.server.config.security.group.UserGroup;
import pl.sherpout.server.api.user.logic.TokenService;
import pl.sherpout.server.config.security.group.SecuredByGroup;


@RestController
@RequestMapping("me")
@RequiredArgsConstructor
public class MeController {

    private final TokenService tokenService;

    @GetMapping
    @SecuredByGroup(UserGroup.USER)
    public ResponseEntity<UserDto> getUserInfo(JwtAuthenticationToken auth) {
        return ResponseEntity
                .ok()
                .body(tokenService.getUser(auth));
    }
}
