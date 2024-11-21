package org.dongguk.dscd.wooahan.api.security.repository.redis;

import org.dongguk.dscd.wooahan.api.security.domain.redis.AuthenticationCodeHistory;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface AuthenticationCodeHistoryRepository extends CrudRepository<AuthenticationCodeHistory, String> {
}
