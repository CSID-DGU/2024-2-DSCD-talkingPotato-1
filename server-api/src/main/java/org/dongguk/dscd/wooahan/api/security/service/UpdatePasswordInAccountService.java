package org.dongguk.dscd.wooahan.api.security.service;

import lombok.RequiredArgsConstructor;
import org.dongguk.dscd.wooahan.api.core.exception.error.ErrorCode;
import org.dongguk.dscd.wooahan.api.core.exception.type.CommonException;
import org.dongguk.dscd.wooahan.api.security.domain.mysql.Account;
import org.dongguk.dscd.wooahan.api.security.domain.type.EProvider;
import org.dongguk.dscd.wooahan.api.security.dto.request.UpdatePasswordInAccountDto;
import org.dongguk.dscd.wooahan.api.security.repository.mysql.AccountRepository;
import org.dongguk.dscd.wooahan.api.security.usecase.UpdatePasswordInAccountUseCase;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.UUID;

@Service
@RequiredArgsConstructor
public class UpdatePasswordInAccountService implements UpdatePasswordInAccountUseCase {

    private final AccountRepository accountRepository;

    private final BCryptPasswordEncoder bCryptPasswordEncoder;

    @Override
    @Transactional
    public void execute(
            UUID accountId,
            UpdatePasswordInAccountDto requestDto
    ) {
        Account account = accountRepository.findById(accountId)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        if (account.getProvider() != EProvider.DEFAULT) {
            throw new CommonException(ErrorCode.ACCESS_DENIED);
        }

        if (bCryptPasswordEncoder.matches(requestDto.password(), account.getPassword())) {
            throw new CommonException(ErrorCode.DUPLICATE_PASSWORD);
        }

        account.updatePassword(bCryptPasswordEncoder.encode(requestDto.password()));
    }
}
