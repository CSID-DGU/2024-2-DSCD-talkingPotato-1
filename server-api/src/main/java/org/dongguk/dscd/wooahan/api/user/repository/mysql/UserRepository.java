package org.dongguk.dscd.wooahan.api.user.repository.mysql;

import org.dongguk.dscd.wooahan.api.user.domain.mysql.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.UUID;

@Repository
public interface UserRepository extends JpaRepository<User, UUID> {
}
