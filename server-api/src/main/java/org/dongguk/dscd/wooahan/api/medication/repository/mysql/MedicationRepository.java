package org.dongguk.dscd.wooahan.api.medication.repository.mysql;

import org.dongguk.dscd.wooahan.api.medication.domain.mysql.Medication;
import org.dongguk.dscd.wooahan.api.user.domain.mysql.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface MedicationRepository extends JpaRepository<Medication, Long> {

    boolean existsByDrugIdAndCreator(Integer drugId, User creator);

    List<Medication> findAllByCreator(User creator);

}
