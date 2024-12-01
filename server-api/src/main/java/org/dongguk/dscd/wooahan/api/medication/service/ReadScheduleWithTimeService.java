package org.dongguk.dscd.wooahan.api.medication.service;

import lombok.RequiredArgsConstructor;
import org.dongguk.dscd.wooahan.api.medication.domain.mysql.Medication;
import org.dongguk.dscd.wooahan.api.medication.domain.type.ETakenTime;
import org.dongguk.dscd.wooahan.api.medication.dto.response.ReadScheduleWithTimeDto;
import org.dongguk.dscd.wooahan.api.medication.repository.mysql.MedicationRepository;
import org.dongguk.dscd.wooahan.api.medication.repository.mysql.ScheduleRepository;
import org.dongguk.dscd.wooahan.api.medication.usecase.ReadScheduleWithTimeUseCase;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class ReadScheduleWithTimeService implements ReadScheduleWithTimeUseCase {

    private final MedicationRepository medicationRepository;

    private final ScheduleRepository scheduleRepository;

    @Override
    public ReadScheduleWithTimeDto execute(
            UUID accountId,
            ETakenTime time
    ) {

        List<Medication> medications = medicationRepository.findAllByAccountIdAndTime(accountId, time.getEnName());

        LocalDate today = LocalDate.now();

        return ReadScheduleWithTimeDto.builder()
                .drugs(
                        medications.stream()
                                .map(medication -> ReadScheduleWithTimeDto.ReadScheduleDto.builder()
                                        .drugId(medication.getDrugId())
                                        .isTaken(scheduleRepository.existsByMedicationAndTakenTimeAndTookAt(
                                                medication, time, today))
                                        .build()
                                )
                                .toList())
                .build();

        // 유저 찾고
        // 유저와 해당 시간대가 true인 Medication들 찾아서
        // 해당 drug_id를 가지는 오늘 날짜의 Schedule이 있는지 확인하고
        // 있으면 is_taken을 true 없으면 false로 해서 보내기

    }
}
