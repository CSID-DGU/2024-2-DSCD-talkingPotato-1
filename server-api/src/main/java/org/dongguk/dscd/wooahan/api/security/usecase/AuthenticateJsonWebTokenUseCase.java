package org.dongguk.dscd.wooahan.api.security.usecase;

import org.dongguk.dscd.wooahan.api.security.info.UserPrincipal;

import java.util.UUID;

public interface AuthenticateJsonWebTokenUseCase {

    /**
     * Get UserDetails by accountId
     * @param accountId UUID
     * @return UserDetails
     */
    UserPrincipal execute(UUID accountId);
}
