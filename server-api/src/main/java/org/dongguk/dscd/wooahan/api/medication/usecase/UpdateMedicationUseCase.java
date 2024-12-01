package org.dongguk.dscd.wooahan.api.medication.usecase;

import org.dongguk.dscd.wooahan.api.medication.dto.request.UpdateMedicationDto;

import java.util.UUID;

public interface UpdateMedicationUseCase {
    /**
     * 약 수정
     * @param accountId 계정 ID
     * @param requestDto 요청 DTO
     */
    void execute(
            UUID accountId,
            UpdateMedicationDto requestDto
    );
}
