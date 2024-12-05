package org.dongguk.dscd.wooahan.api.user.service;

import lombok.RequiredArgsConstructor;
import org.dongguk.dscd.wooahan.api.core.exception.error.ErrorCode;
import org.dongguk.dscd.wooahan.api.core.exception.type.CommonException;
import org.dongguk.dscd.wooahan.api.user.domain.mysql.User;
import org.dongguk.dscd.wooahan.api.user.dto.request.UpdateUserDeviceTokenDto;
import org.dongguk.dscd.wooahan.api.user.repository.mysql.UserRepository;
import org.dongguk.dscd.wooahan.api.user.usecase.UpdateUserDeviceTokenUseCase;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.UUID;

@Service
@RequiredArgsConstructor
public class UpdateUserDeviceTokenService implements UpdateUserDeviceTokenUseCase {

    private final UserRepository userRepository;

    @Override
    @Transactional
    public void execute(
            UUID accountId,
            UpdateUserDeviceTokenDto requestDto
    ) {
        User user = userRepository.findById(accountId)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        user.updateDeviceToken(requestDto.deviceToken());
    }
}
