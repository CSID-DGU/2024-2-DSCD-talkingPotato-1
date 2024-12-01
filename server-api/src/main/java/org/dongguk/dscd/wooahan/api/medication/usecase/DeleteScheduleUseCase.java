package org.dongguk.dscd.wooahan.api.medication.usecase;

import org.dongguk.dscd.wooahan.api.medication.domain.type.ETakenTime;

import java.time.LocalDate;
import java.util.UUID;

public interface DeleteScheduleUseCase {
    /**
     * 약 복용 취소
     * @param accountId 계정 ID
     * @param id 약품 ID
     * @param time 복용 시간대
     * @param date 복용 날짜
     */
    void execute(
            UUID accountId,
            Integer id,
            ETakenTime time,
            LocalDate date
    );
}
