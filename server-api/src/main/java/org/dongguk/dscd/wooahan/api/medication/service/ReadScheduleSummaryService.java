package org.dongguk.dscd.wooahan.api.medication.service;

import lombok.RequiredArgsConstructor;
import org.dongguk.dscd.wooahan.api.medication.domain.mysql.Medication;
import org.dongguk.dscd.wooahan.api.medication.domain.type.ETakenTime;
import org.dongguk.dscd.wooahan.api.medication.dto.response.ReadScheduleSummaryDto;
import org.dongguk.dscd.wooahan.api.medication.repository.mysql.MedicationRepository;
import org.dongguk.dscd.wooahan.api.medication.repository.mysql.ScheduleRepository;
import org.dongguk.dscd.wooahan.api.medication.usecase.ReadScheduleSummaryUseCase;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class ReadScheduleSummaryService implements ReadScheduleSummaryUseCase {

    private final MedicationRepository medicationRepository;

    private final ScheduleRepository scheduleRepository;

    @Override
    public ReadScheduleSummaryDto execute(UUID accountId) {
        LocalDate today = LocalDate.now();

        return ReadScheduleSummaryDto.builder()
                .breakfast(getSummary(accountId, today, ETakenTime.BREAKFAST))
                .lunch(getSummary(accountId, today, ETakenTime.LUNCH))
                .dinner(getSummary(accountId, today, ETakenTime.DINNER))
                .daily(getSummary(accountId, today, ETakenTime.DAILY))
                .build();
    }


    private ReadScheduleSummaryDto.ReadSummaryDto getSummary(UUID accountId, LocalDate today, ETakenTime takenTime) {
        List<Medication> medications = medicationRepository.findAllByAccountIdAndTime(accountId, takenTime.getEnName());

        if (medications.isEmpty()) {
            return ReadScheduleSummaryDto.ReadSummaryDto.builder()
                    .totalDrugCount(0)
                    .takenDrugCount(0)
                    .build();
        }

        List<Long> medicationIds = medications.stream()
                .map(Medication::getId)
                .toList();
        int takenCount = scheduleRepository.countTakenSchedules(medicationIds, takenTime, today);

        return ReadScheduleSummaryDto.ReadSummaryDto.builder()
                .totalDrugCount(medications.size())
                .takenDrugCount(takenCount)
                .build();
    }
}
