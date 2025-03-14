package com.sherpout.server.config.security;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.oauth2.jwt.JwtDecoders;
import org.springframework.security.oauth2.server.resource.authentication.JwtAuthenticationConverter;
import org.springframework.security.oauth2.server.resource.authentication.JwtAuthenticationProvider;
import org.springframework.security.oauth2.server.resource.authentication.JwtIssuerAuthenticationManagerResolver;
import org.springframework.security.web.SecurityFilterChain;
import com.sherpout.server.config.security.group.UserGroup;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Configuration
@EnableMethodSecurity
public class SecurityConfig {
    private final Map<String, AuthenticationManager> authenticationManagers = new HashMap<>();

    private final JwtIssuerAuthenticationManagerResolver authenticationManagerResolver =
            new JwtIssuerAuthenticationManagerResolver(authenticationManagers::get);

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        List<String> issuers = new ArrayList<>();
        issuers.add("http://192.168.100.45:8082/realms/Sherpout");
        issuers.add("http://localhost:8082/realms/Sherpout");

        issuers.forEach(issuer -> addManager(authenticationManagers, issuer));

        http.authorizeHttpRequests(authz -> authz.anyRequest().authenticated())
                .oauth2ResourceServer(oauth2 -> oauth2
                        .authenticationManagerResolver(authenticationManagerResolver)
                );
        return http.build();
    }

    private void addManager(Map<String, AuthenticationManager> authenticationManagers, String issuer) {
        JwtAuthenticationProvider authenticationProvider = new JwtAuthenticationProvider(JwtDecoders.fromOidcIssuerLocation(issuer));
        authenticationProvider.setJwtAuthenticationConverter(getJwtAuthenticationConverter());
        authenticationManagers.put(issuer, authenticationProvider::authenticate);
    }

    private JwtAuthenticationConverter getJwtAuthenticationConverter() {
        return new JwtAuthenticationConverter() {{
            setJwtGrantedAuthoritiesConverter(jwt -> {
                List<String> groups = jwt.getClaimAsStringList("groups");
                if (groups == null || groups.isEmpty()) {
                    groups = List.of(UserGroup.DEFAULT.getRole());
                }

                return groups.stream()
                        .map(group -> group.replace("/", "").toUpperCase())
                        .map(SimpleGrantedAuthority::new)
                        .collect(Collectors.toList());
            });
        }};
    }
}
