package org.dongguk.dscd.wooahan.api.medication.usecase;

import org.dongguk.dscd.wooahan.api.medication.dto.response.ReadUserMedicationListDto;

import java.util.UUID;

public interface ReadUserMedicationListUseCase {
    /**
     * 사용자 복약 목록 조회
     * @param accountId 계정 ID
     */
    ReadUserMedicationListDto execute(UUID accountId);

}
