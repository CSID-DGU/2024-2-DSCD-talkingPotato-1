package org.dongguk.dscd.wooahan.api.medication.usecase;

import org.dongguk.dscd.wooahan.api.medication.dto.request.CreateMedicationDto;

import java.util.UUID;

public interface CreateMedicationUseCase {
    /**
     * 약 추가
     * @param accountId 계정 ID
     * @param requestDto 약 추가 DTO
     */
    void execute(
            UUID accountId,
            CreateMedicationDto requestDto
    );
}
