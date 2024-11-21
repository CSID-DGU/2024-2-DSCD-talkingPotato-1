package org.dongguk.dscd.wooahan.api.security.info;

import lombok.Builder;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import org.dongguk.dscd.wooahan.api.security.domain.mysql.Account;
import org.dongguk.dscd.wooahan.api.security.domain.type.ERole;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.Collection;
import java.util.Collections;
import java.util.UUID;

@Builder
@RequiredArgsConstructor
public class UserPrincipal implements UserDetails {

    @Getter private final UUID id;
    @Getter private final ERole role;
    private final String password;
    private final Collection<? extends GrantedAuthority> authorities;

    public static UserPrincipal create(Account account) {
        return UserPrincipal.builder()
                .id(account.getId())
                .role(account.getRole())
                .password(account.getPassword())
                .authorities(Collections.singleton(new SimpleGrantedAuthority(account.getRole().getSecurityName())))
                .build();
    }

    @Override
    public String getUsername() {
        return id.toString();
    }

    @Override
    public String getPassword() {
        return password;
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return authorities;
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return true;
    }
}

