package org.dongguk.dscd.wooahan.api.user.service;

import lombok.RequiredArgsConstructor;
import org.dongguk.dscd.wooahan.api.core.exception.error.ErrorCode;
import org.dongguk.dscd.wooahan.api.core.exception.type.CommonException;
import org.dongguk.dscd.wooahan.api.user.domain.mysql.User;
import org.dongguk.dscd.wooahan.api.user.dto.request.UpdateUserNotificationTimeDto;
import org.dongguk.dscd.wooahan.api.user.repository.mysql.UserRepository;
import org.dongguk.dscd.wooahan.api.user.usecase.UpdateUserNotificationTimeUseCase;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.UUID;

@Service
@RequiredArgsConstructor
public class UpdateUserNotificationTimeService implements UpdateUserNotificationTimeUseCase {

    private final UserRepository userRepository;

    @Override
    @Transactional
    public void execute(
            UUID accountId,
            UpdateUserNotificationTimeDto requestDto
    ) {
        User user = userRepository.findById(accountId)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        switch (requestDto.type()) {
            case BREAKFAST -> user.updateBreakfastTime(requestDto.time());
            case LUNCH -> user.updateLunchTime(requestDto.time());
            case DINNER -> user.updateDinnerTime(requestDto.time());
            default -> throw new CommonException(ErrorCode.BAD_REQUEST_PARAMETER);
        }
    }
}
