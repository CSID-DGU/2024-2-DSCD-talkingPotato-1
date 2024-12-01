package org.dongguk.dscd.wooahan.api.medication.controller.query;

import lombok.RequiredArgsConstructor;
import org.dongguk.dscd.wooahan.api.core.annotation.common.AccountID;
import org.dongguk.dscd.wooahan.api.core.dto.ResponseDto;
import org.dongguk.dscd.wooahan.api.medication.domain.type.ETakenTime;
import org.dongguk.dscd.wooahan.api.medication.usecase.ReadScheduleSummaryUseCase;
import org.dongguk.dscd.wooahan.api.medication.usecase.ReadScheduleWithTimeUseCase;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.UUID;

@RestController
@RequiredArgsConstructor
@RequestMapping("/v1/schedules")
public class ScheduleQueryV1Controller {

    private final ReadScheduleWithTimeUseCase readScheduleWithTimeUseCase;
    private final ReadScheduleSummaryUseCase readScheduleSummaryUseCase;

    /**
     * 6-1. 복약 기록 조회
     * @param accountId 계정 ID
     * @param time 조회 시간대
     * @return 응답 DTO
     */
    @PreAuthorize("hasRole('USER')")
    @GetMapping
    public ResponseDto<?> readScheduleWithTime(
            @AccountID UUID accountId,
            @RequestParam ETakenTime time
    ) {
        return ResponseDto.ok(readScheduleWithTimeUseCase.execute(accountId, time));
    }

    /**
     * 6-2. 오늘 복약 정도 요약 조회
     * @param accountId 계정 ID
     * @return 응답 DTO
     */
    @PreAuthorize("hasRole('USER')")
    @GetMapping("/summary")
    public ResponseDto<?> readScheduleSummary(@AccountID UUID accountId) {
        return ResponseDto.ok(readScheduleSummaryUseCase.execute(accountId));
    }

}
