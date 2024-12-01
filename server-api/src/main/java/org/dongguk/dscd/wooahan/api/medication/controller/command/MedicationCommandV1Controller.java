package org.dongguk.dscd.wooahan.api.medication.controller.command;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.dongguk.dscd.wooahan.api.core.annotation.common.AccountID;
import org.dongguk.dscd.wooahan.api.core.dto.ResponseDto;
import org.dongguk.dscd.wooahan.api.medication.dto.request.CreateMedicationDto;
import org.dongguk.dscd.wooahan.api.medication.dto.request.UpdateMedicationDto;
import org.dongguk.dscd.wooahan.api.medication.usecase.CreateMedicationUseCase;
import org.dongguk.dscd.wooahan.api.medication.usecase.UpdateMedicationUseCase;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;

@RestController
@RequiredArgsConstructor
@RequestMapping("/v1/medications")
public class MedicationCommandV1Controller {

    private final CreateMedicationUseCase createMedicationUseCase;
    private final UpdateMedicationUseCase updateMedicationUseCase;

    /**
     * 5-1. 약 추가
     *
     * @param accountId  계정 ID
     * @param requestDto 요청 DTO
     * @return 응답 DTO
     */
    @PreAuthorize("hasRole('USER')")
    @PostMapping
    public ResponseDto<?> createMedication(
            @AccountID UUID accountId,
            @RequestBody @Valid CreateMedicationDto requestDto
    ) {
        createMedicationUseCase.execute(accountId, requestDto);

        return ResponseDto.ok(null);
    }


    /**
     * 5-2. 약 수정
     *
     * @param accountId 계정 ID
     * @param requestDto 요청 DTO
     * @return 응답 DTO
     */
    @PreAuthorize("hasRole('USER')")
    @PutMapping
    public ResponseDto<?> updateMedication(
            @AccountID UUID accountId,
            @RequestBody @Valid UpdateMedicationDto requestDto
    ) {
        updateMedicationUseCase.execute(accountId, requestDto);

        return ResponseDto.ok(null);
    }

}
