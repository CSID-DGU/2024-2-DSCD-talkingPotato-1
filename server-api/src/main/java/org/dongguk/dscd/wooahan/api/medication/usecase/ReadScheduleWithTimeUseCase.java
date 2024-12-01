package org.dongguk.dscd.wooahan.api.medication.usecase;

import org.dongguk.dscd.wooahan.api.medication.domain.type.ETakenTime;
import org.dongguk.dscd.wooahan.api.medication.dto.response.ReadScheduleWithTimeDto;

import java.util.UUID;

public interface ReadScheduleWithTimeUseCase {
    /**
     * 복약 기록 조회
     * @param accountId 계정 ID
     * @param time 조회 시간대
     */
    ReadScheduleWithTimeDto execute(
            UUID accountId,
            ETakenTime time
    );
}
