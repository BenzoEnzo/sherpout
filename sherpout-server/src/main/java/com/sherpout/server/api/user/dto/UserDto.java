package com.sherpout.server.api.user.dto;

import lombok.Getter;
import lombok.Setter;
import com.sherpout.server.config.security.group.UserGroup;

@Getter
@Setter
public class UserDto {
    private UserGroup group;
    private String firstName;
    private String lastName;
    private String email;
    private boolean emailVerified;
}
