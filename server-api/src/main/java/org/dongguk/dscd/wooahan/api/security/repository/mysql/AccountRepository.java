package org.dongguk.dscd.wooahan.api.security.repository.mysql;

import org.dongguk.dscd.wooahan.api.security.domain.mysql.Account;
import org.dongguk.dscd.wooahan.api.security.domain.type.EProvider;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;
import java.util.UUID;

@Repository
public interface AccountRepository extends JpaRepository<Account, UUID>{

    Optional<Account> findBySerialId(String serialId);

    Optional<Account> findBySerialIdAndProvider(String serialId, EProvider provider);
}
