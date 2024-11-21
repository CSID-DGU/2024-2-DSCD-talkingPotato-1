package org.dongguk.dscd.wooahan.api.security.usecase;

import org.dongguk.dscd.wooahan.api.security.dto.response.DefaultJsonWebTokenDto;
import org.dongguk.dscd.wooahan.api.security.info.UserPrincipal;

public interface LoginByDefaultUseCase {

    /**
     * Security에서 사용되는 Login 유스케이스
     * @param principal UserPrincipal
     * @param jsonWebTokenDto DefaultJsonWebTokenDto
     */
    void execute(
            UserPrincipal principal,
            DefaultJsonWebTokenDto jsonWebTokenDto
    );
}
