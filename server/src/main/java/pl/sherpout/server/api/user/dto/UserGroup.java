package pl.sherpout.server.api.user.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum UserGroup {
    USER("USER"),
    TRAINER("TRAINER"),
    ADMIN("ADMIN");

    private final String role;
}
