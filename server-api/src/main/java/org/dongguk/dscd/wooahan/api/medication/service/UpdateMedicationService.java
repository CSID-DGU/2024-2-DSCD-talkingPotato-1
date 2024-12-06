package org.dongguk.dscd.wooahan.api.medication.service;

import lombok.RequiredArgsConstructor;
import org.dongguk.dscd.wooahan.api.core.exception.error.ErrorCode;
import org.dongguk.dscd.wooahan.api.core.exception.type.CommonException;
import org.dongguk.dscd.wooahan.api.medication.domain.mysql.Medication;
import org.dongguk.dscd.wooahan.api.medication.dto.request.UpdateMedicationDto;
import org.dongguk.dscd.wooahan.api.medication.repository.mysql.MedicationRepository;
import org.dongguk.dscd.wooahan.api.medication.usecase.UpdateMedicationUseCase;
import org.dongguk.dscd.wooahan.api.user.domain.mysql.User;
import org.dongguk.dscd.wooahan.api.user.repository.mysql.UserRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class UpdateMedicationService implements UpdateMedicationUseCase {

    private final UserRepository userRepository;

    private final MedicationRepository medicationRepository;

    @Override
    @Transactional
    public void execute(
            UUID accountId,
            UpdateMedicationDto requestDto
    ) {

        // 1. 사용자 조회
        User user = userRepository.findById(accountId)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        // 2. 복약 기록 조회
        List<Medication> medications =  medicationRepository.findAllByCreator(user);

        // 3. 복약 기록 업데이트
        Map<Integer, UpdateMedicationDto.MedicationDto> newMedicationMap = requestDto.medications()
                .stream()
                .collect(Collectors.toMap(UpdateMedicationDto.MedicationDto::drugId, med -> med));

        for (Medication medication : medications) {
            UpdateMedicationDto.MedicationDto updateMedication = newMedicationMap.get(medication.getDrugId());
            if (updateMedication != null) {
                if (shouldDelete(updateMedication)) {
                    medicationRepository.delete(medication);
                } else {
                    medication.updateIsTakenInBreakfast(updateMedication.isTakenInBreakfast());
                    medication.updateIsTakenInLunch(updateMedication.isTakenInLunch());
                    medication.updateIsTakenInDinner(updateMedication.isTakenInDinner());
                    medication.updateIsTakenInDaily(updateMedication.isTakenInDaily());
                }
            } else {
                medicationRepository.delete(medication);
            }
        }
    }

    private boolean shouldDelete(UpdateMedicationDto.MedicationDto medication) {
        return !(
                medication.isTakenInBreakfast() ||
                medication.isTakenInLunch() ||
                medication.isTakenInDinner() ||
                medication.isTakenInDaily()
        );
    }
}
