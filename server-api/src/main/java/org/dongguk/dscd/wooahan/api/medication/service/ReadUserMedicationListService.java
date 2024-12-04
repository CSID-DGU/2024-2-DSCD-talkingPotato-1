package org.dongguk.dscd.wooahan.api.medication.service;

import lombok.RequiredArgsConstructor;
import org.dongguk.dscd.wooahan.api.core.exception.error.ErrorCode;
import org.dongguk.dscd.wooahan.api.core.exception.type.CommonException;
import org.dongguk.dscd.wooahan.api.medication.domain.mysql.Medication;
import org.dongguk.dscd.wooahan.api.medication.dto.response.ReadUserMedicationListDto;
import org.dongguk.dscd.wooahan.api.medication.repository.mysql.MedicationRepository;
import org.dongguk.dscd.wooahan.api.medication.usecase.ReadUserMedicationListUseCase;
import org.dongguk.dscd.wooahan.api.user.domain.mysql.User;
import org.dongguk.dscd.wooahan.api.user.repository.mysql.UserRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class ReadUserMedicationListService implements ReadUserMedicationListUseCase {

    private final UserRepository userRepository;

    private final MedicationRepository medicationRepository;

    @Override
    public ReadUserMedicationListDto execute(UUID accountId) {
        User user = userRepository.findById(accountId)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        List<Medication> medications = medicationRepository.findAllByCreator(user);

        return ReadUserMedicationListDto.builder()
                .medications(
                        medications.stream()
                                .map(medication -> ReadUserMedicationListDto.UserMedicationDto.builder()
                                        .drugId(medication.getDrugId())
                                        .isTakenInBreakfast(medication.getIsTakenInBreakfast())
                                        .isTakenInLunch(medication.getIsTakenInLunch())
                                        .isTakenInDinner(medication.getIsTakenInDinner())
                                        .isTakenInDaily(medication.getIsTakenInDaily())
                                        .build()
                                )
                                .toList()
                )
                .build();
    }
}
