package pl.sherpout.server.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.oauth2.server.resource.authentication.JwtAuthenticationConverter;
import org.springframework.security.web.SecurityFilterChain;

import java.util.List;
import java.util.stream.Collectors;

@Configuration
@EnableMethodSecurity
public class SecurityConfig {
    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http.authorizeHttpRequests(authz -> authz.anyRequest().authenticated())
                .oauth2ResourceServer(oauth2 -> oauth2
                        .jwt(jwtConfigurer -> jwtConfigurer.jwtAuthenticationConverter(jwtAuthenticationConverter()))
                );
        return http.build();
    }

    @Bean
    public JwtAuthenticationConverter jwtAuthenticationConverter() {
        return new JwtAuthenticationConverter() {{
            setJwtGrantedAuthoritiesConverter(jwt -> {
                List<String> groups = jwt.getClaimAsStringList("groups"); // Pobranie grup z JWT
                if (groups == null) return List.of();

                return groups.stream()
                        .map(group -> group.replace("/", "").toUpperCase()) // Prefix "GROUP_" i usunięcie "/"
                        .map(SimpleGrantedAuthority::new)
                        .collect(Collectors.toList());
            });
        }};
    }
}
