package org.dongguk.dscd.wooahan.api.security.repository.redis;

import org.dongguk.dscd.wooahan.api.security.domain.redis.AuthenticationCode;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface AuthenticationCodeRepository extends CrudRepository<AuthenticationCode, String> {
}

