package org.dongguk.dscd.wooahan.api.medication.usecase;

import org.dongguk.dscd.wooahan.api.medication.dto.response.ReadScheduleSummaryDto;

import java.util.UUID;

public interface ReadScheduleSummaryUseCase {
    /**
     * 오늘 복약 정도 요약 조회
     * @param accountId 계정 ID
     */
    ReadScheduleSummaryDto execute(UUID accountId);
}
