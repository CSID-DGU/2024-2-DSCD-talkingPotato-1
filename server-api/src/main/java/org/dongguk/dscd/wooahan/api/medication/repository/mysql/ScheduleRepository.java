package org.dongguk.dscd.wooahan.api.medication.repository.mysql;

import org.dongguk.dscd.wooahan.api.medication.domain.mysql.Medication;
import org.dongguk.dscd.wooahan.api.medication.domain.mysql.Schedule;
import org.dongguk.dscd.wooahan.api.medication.domain.type.ETakenTime;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;


public interface ScheduleRepository extends JpaRepository<Schedule, Long> {

    boolean existsByMedicationAndTakenTimeAndTookAt(Medication medication, ETakenTime takenTime, LocalDate tookAt);

    @Query("""
        SELECT COUNT(s)
        FROM Schedule s
        WHERE s.medication.id IN :medicationIds
          AND s.takenTime = :takenTime
          AND s.tookAt = :tookAt
    """)
    int countTakenSchedules(List<Long> medicationIds, ETakenTime takenTime, LocalDate tookAt);

    Optional<Schedule> findByMedicationAndTakenTimeAndTookAt(Medication medication, ETakenTime takenTime, LocalDate tookAt);

}
