package com.sherpout.server.api.user.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.sherpout.server.api.user.dto.UserDto;
import com.sherpout.server.config.security.group.UserGroup;
import com.sherpout.server.api.user.logic.TokenService;
import com.sherpout.server.config.security.group.SecuredByGroup;

@RestController
@RequestMapping("me")
@RequiredArgsConstructor
public class MeController {

    private final TokenService tokenService;

    @GetMapping
    @SecuredByGroup(UserGroup.USER)
    public ResponseEntity<UserDto> getUserInfo() {
        return ResponseEntity
                .status(HttpStatus.OK)
                .body(tokenService.getUser());
    }
}
