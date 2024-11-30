package org.dongguk.dscd.wooahan.api.user.service;

import lombok.RequiredArgsConstructor;
import org.dongguk.dscd.wooahan.api.core.exception.error.ErrorCode;
import org.dongguk.dscd.wooahan.api.core.exception.type.CommonException;
import org.dongguk.dscd.wooahan.api.user.domain.mysql.User;
import org.dongguk.dscd.wooahan.api.user.dto.response.ReadUserDto;
import org.dongguk.dscd.wooahan.api.user.repository.mysql.UserRepository;
import org.dongguk.dscd.wooahan.api.user.usecase.ReadUserUseCase;
import org.springframework.stereotype.Service;

import java.util.UUID;

@Service
@RequiredArgsConstructor
public class ReadUserService implements ReadUserUseCase {

    private final UserRepository userRepository;

    @Override
    public ReadUserDto execute(UUID accountId) {
        User user = userRepository.findById(accountId)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        return ReadUserDto.builder()
                .id(user.getId())
                .nickname(user.getNickname())
                .isAllowedNotification(user.getIsAllowedNotification())
                .breakfastTime(user.getBreakfastTime())
                .lunchTime(user.getLunchTime())
                .dinnerTime(user.getDinnerTime())
                .isValidatedPass(false)
                .build();
    }
}
