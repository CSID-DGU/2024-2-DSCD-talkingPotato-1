package org.dongguk.dscd.wooahan.api.medication.controller.command;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.dongguk.dscd.wooahan.api.core.annotation.common.AccountID;
import org.dongguk.dscd.wooahan.api.core.dto.ResponseDto;
import org.dongguk.dscd.wooahan.api.medication.domain.type.ETakenTime;
import org.dongguk.dscd.wooahan.api.medication.dto.request.CreateScheduleDto;
import org.dongguk.dscd.wooahan.api.medication.usecase.CreateScheduleUseCase;
import org.dongguk.dscd.wooahan.api.medication.usecase.DeleteScheduleUseCase;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.UUID;

@RestController
@RequiredArgsConstructor
@RequestMapping("/v1/schedules")
public class ScheduleCommandV1Controller {

    private final CreateScheduleUseCase createScheduleUseCase;

    private final DeleteScheduleUseCase deleteScheduleUseCase;

    /**
     * 6-3. 약 복용
     *
     * @param accountId  계정 ID
     * @param requestDto 요청 DTO
     * @return 응답 DTO
     */
    @PreAuthorize("hasRole('USER')")
    @PostMapping
    public ResponseDto<?> createSchedule(
            @AccountID UUID accountId,
            @RequestBody @Valid CreateScheduleDto requestDto
    ) {
        createScheduleUseCase.execute(accountId, requestDto);

        return ResponseDto.ok(null);
    }

    /**
     * 6-4. 약 복용 취소
     *
     * @param accountId 계정 ID
     * @param drugId       약품 ID
     * @param time     복용 시간대
     * @param date     복용 날짜
     * @return 응답 DTO
     */
    @PreAuthorize("hasRole('USER')")
    @DeleteMapping
    public ResponseDto<?> deleteSchedule(
            @AccountID UUID accountId,
            @RequestParam(name = "id") Integer drugId,
            @RequestParam ETakenTime time,
            @RequestParam @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate date
    ) {
        deleteScheduleUseCase.execute(accountId, drugId, time, date);

        return ResponseDto.ok(null);
    }

}
