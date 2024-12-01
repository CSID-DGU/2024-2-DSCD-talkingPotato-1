package org.dongguk.dscd.wooahan.api.medication.service;

import lombok.RequiredArgsConstructor;
import org.dongguk.dscd.wooahan.api.core.exception.error.ErrorCode;
import org.dongguk.dscd.wooahan.api.core.exception.type.CommonException;
import org.dongguk.dscd.wooahan.api.medication.domain.mysql.Medication;
import org.dongguk.dscd.wooahan.api.medication.domain.mysql.Schedule;
import org.dongguk.dscd.wooahan.api.medication.dto.request.CreateScheduleDto;
import org.dongguk.dscd.wooahan.api.medication.repository.mysql.MedicationRepository;
import org.dongguk.dscd.wooahan.api.medication.repository.mysql.ScheduleRepository;
import org.dongguk.dscd.wooahan.api.medication.usecase.CreateScheduleUseCase;
import org.springframework.stereotype.Service;

import java.util.UUID;

@Service
@RequiredArgsConstructor
public class CreateScheduleService implements CreateScheduleUseCase {

    private final ScheduleRepository scheduleRepository;

    private final MedicationRepository medicationRepository;

    @Override
    public void execute(
            UUID accountId,
            CreateScheduleDto requestDto
    ) {
        Medication medication = medicationRepository.findByDrugIdAndCreatorAndTime(
                requestDto.drugId(), accountId, requestDto.time().getEnName())
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_MEDICATION));

        if (scheduleRepository.existsByMedicationAndTakenTimeAndTookAt(
                medication, requestDto.time(), requestDto.date())) {
            throw new CommonException(ErrorCode.CONFLICT_SCHEDULE);
        }

        Schedule schedule = Schedule.builder()
                .tookAt(requestDto.date())
                .takenTime(requestDto.time())
                .medication(medication)
                .build();

        scheduleRepository.save(schedule);
    }
}
