package org.dongguk.dscd.wooahan.api.security.usecase;

import org.dongguk.dscd.wooahan.api.security.info.UserPrincipal;

public interface LogoutUseCase {

    /**
     * Security 단에서 사용되는 Logout 유스케이스
     * @param principal UserPrincipal
     */
    void execute(UserPrincipal principal);
}
