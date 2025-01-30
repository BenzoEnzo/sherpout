package pl.sherpout.server.config.security.group;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum UserGroup {
    DEFAULT("DEFAULT", 0),
    USER("USER", 1),
    TRAINER("TRAINER", 2),
    ADMIN("ADMIN", 3);

    private final String role;
    private final Integer accessLevel;
}
