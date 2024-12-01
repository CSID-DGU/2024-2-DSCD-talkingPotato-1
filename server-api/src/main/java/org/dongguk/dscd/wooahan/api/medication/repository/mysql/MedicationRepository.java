package org.dongguk.dscd.wooahan.api.medication.repository.mysql;

import org.dongguk.dscd.wooahan.api.medication.domain.mysql.Medication;
import org.dongguk.dscd.wooahan.api.user.domain.mysql.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface MedicationRepository extends JpaRepository<Medication, Long> {

    boolean existsByDrugIdAndCreator(Integer drugId, User creator);

    List<Medication> findAllByCreator(User creator);

    @Query("""
        SELECT m FROM Medication m
        WHERE m.creator.id = :accountId
          AND (
              (:time = 'BREAKFAST' AND m.isTakenInBreakfast = true) OR
              (:time = 'LUNCH' AND m.isTakenInLunch = true) OR
              (:time = 'DINNER' AND m.isTakenInDinner = true) OR
              (:time = 'DAILY' AND m.isTakenInDaily = true)
          )
    """)
    List<Medication> findAllByAccountIdAndTime(UUID accountId, String time);

    @Query("""
        SELECT m FROM Medication m
        WHERE m.creator.id = :accountId
          AND m.drugId = :drugId
          AND (
              (:time = 'BREAKFAST' AND m.isTakenInBreakfast = true) OR
              (:time = 'LUNCH' AND m.isTakenInLunch = true) OR
              (:time = 'DINNER' AND m.isTakenInDinner = true) OR
              (:time = 'DAILY' AND m.isTakenInDaily = true)
          )
    """)
    Optional<Medication> findByDrugIdAndCreatorAndTime(Integer drugId, UUID accountId, String time);

}
