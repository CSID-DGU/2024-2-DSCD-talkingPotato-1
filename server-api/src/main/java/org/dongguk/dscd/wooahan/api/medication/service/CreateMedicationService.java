package org.dongguk.dscd.wooahan.api.medication.service;

import lombok.RequiredArgsConstructor;
import org.dongguk.dscd.wooahan.api.core.exception.error.ErrorCode;
import org.dongguk.dscd.wooahan.api.core.exception.type.CommonException;
import org.dongguk.dscd.wooahan.api.medication.domain.mysql.Medication;
import org.dongguk.dscd.wooahan.api.medication.dto.request.CreateMedicationDto;
import org.dongguk.dscd.wooahan.api.medication.repository.mysql.MedicationRepository;
import org.dongguk.dscd.wooahan.api.medication.usecase.CreateMedicationUseCase;
import org.dongguk.dscd.wooahan.api.user.domain.mysql.User;
import org.dongguk.dscd.wooahan.api.user.repository.mysql.UserRepository;
import org.springframework.stereotype.Service;

import java.util.UUID;

@Service
@RequiredArgsConstructor
public class CreateMedicationService implements CreateMedicationUseCase {

    private final UserRepository userRepository;

    private final MedicationRepository medicationRepository;

    @Override
    public void execute(
            UUID accountId,
            CreateMedicationDto requestDto
    ) {
        User user = userRepository.findById(accountId)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        if (medicationRepository.existsByDrugIdAndCreator(requestDto.drugId(), user)) {
            throw new CommonException(ErrorCode.CONFLICT_MEDICATION);
        }

        Medication medication = Medication.builder()
                .drugId(requestDto.drugId())
                .isTakenInBreakfast(requestDto.isTakenInBreakfast())
                .isTakenInLunch(requestDto.isTakenInLunch())
                .isTakenInDinner(requestDto.isTakenInDinner())
                .isTakenInDaily(requestDto.isTakenInDaily())
                .creator(user)
                .build();

        medicationRepository.save(medication);
    }
}
