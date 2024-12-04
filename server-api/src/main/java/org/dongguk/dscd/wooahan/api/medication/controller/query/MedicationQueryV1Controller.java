package org.dongguk.dscd.wooahan.api.medication.controller.query;

import lombok.RequiredArgsConstructor;
import org.dongguk.dscd.wooahan.api.core.annotation.common.AccountID;
import org.dongguk.dscd.wooahan.api.core.dto.ResponseDto;
import org.dongguk.dscd.wooahan.api.medication.usecase.ReadUserMedicationListUseCase;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.UUID;

@RestController
@RequiredArgsConstructor
@RequestMapping("/v1/medications")
public class MedicationQueryV1Controller {

    private final ReadUserMedicationListUseCase readUserMedicationListUseCase;

    /**
     * 5-3. 약 복용 목록 조회
     * @param accountId 사용자 ID
     * @return 응답 DTO
     */
    @PreAuthorize("hasRole('USER')")
    @GetMapping
    public ResponseDto<?> readUserMedicationList(@AccountID UUID accountId) {
        return ResponseDto.ok(readUserMedicationListUseCase.execute(accountId));
    }


}
