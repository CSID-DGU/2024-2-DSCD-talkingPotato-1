package org.dongguk.dscd.wooahan.api.medication.usecase;

import org.dongguk.dscd.wooahan.api.medication.dto.request.CreateScheduleDto;

import java.util.UUID;

public interface CreateScheduleUseCase {
    /**
     * 약 복용
     * @param accountId 계정 ID
     * @param requestDto 약 복용 DTO
     */
    void execute(
            UUID accountId,
            CreateScheduleDto requestDto
    );
}
