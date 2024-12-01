package org.dongguk.dscd.wooahan.api.medication.service;

import lombok.RequiredArgsConstructor;
import org.dongguk.dscd.wooahan.api.core.exception.error.ErrorCode;
import org.dongguk.dscd.wooahan.api.core.exception.type.CommonException;
import org.dongguk.dscd.wooahan.api.medication.domain.mysql.Medication;
import org.dongguk.dscd.wooahan.api.medication.domain.mysql.Schedule;
import org.dongguk.dscd.wooahan.api.medication.domain.type.ETakenTime;
import org.dongguk.dscd.wooahan.api.medication.repository.mysql.MedicationRepository;
import org.dongguk.dscd.wooahan.api.medication.repository.mysql.ScheduleRepository;
import org.dongguk.dscd.wooahan.api.medication.usecase.DeleteScheduleUseCase;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class DeleteScheduleService implements DeleteScheduleUseCase {

    private final MedicationRepository medicationRepository;

    private final ScheduleRepository scheduleRepository;

    @Override
    @Transactional
    public void execute(
            UUID accountId,
            Integer drugId,
            ETakenTime time,
            LocalDate date
    ) {

        Medication medication = medicationRepository.findByDrugIdAndCreatorAndTime(
                        drugId, accountId, time.getEnName())
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_MEDICATION));

        Schedule schedule = scheduleRepository.findByMedicationAndTakenTimeAndTookAt(
                medication, time, date)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_SCHEDULE));

        scheduleRepository.delete(schedule);
    }
}
