package org.dongguk.dscd.wooahan.api.security.repository.redis;

import org.dongguk.dscd.wooahan.api.security.domain.redis.TemporaryToken;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface TemporaryTokenRepository extends CrudRepository<TemporaryToken, String> {
}
