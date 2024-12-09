package org.dongguk.dscd.wooahan.api.security.service;

import lombok.RequiredArgsConstructor;
import org.dongguk.dscd.wooahan.api.security.domain.mysql.Account;
import org.dongguk.dscd.wooahan.api.security.info.UserPrincipal;
import org.dongguk.dscd.wooahan.api.security.repository.mysql.AccountRepository;
import org.dongguk.dscd.wooahan.api.security.usecase.AuthenticateUserNameUseCase;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class AuthenticateUserNameService implements AuthenticateUserNameUseCase {

    private final AccountRepository accountRepository;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        Account account = accountRepository.findBySerialId(username)
                .orElseThrow(() -> new UsernameNotFoundException("User not found with email: " + username));

        return UserPrincipal.create(account);
    }
}
