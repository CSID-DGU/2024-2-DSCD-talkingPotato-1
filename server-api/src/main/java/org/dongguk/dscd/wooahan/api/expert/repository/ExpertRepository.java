package org.dongguk.dscd.wooahan.api.expert.repository;

import org.dongguk.dscd.wooahan.api.expert.domain.mysql.Expert;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.UUID;

@Repository
public interface ExpertRepository extends JpaRepository<Expert, UUID> {
}
