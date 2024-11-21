package org.dongguk.dscd.wooahan.api.security.handler.logout;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import org.dongguk.dscd.wooahan.api.security.info.UserPrincipal;
import org.dongguk.dscd.wooahan.api.security.usecase.LogoutUseCase;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.logout.LogoutHandler;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class DefaultLogoutProcessHandler implements LogoutHandler {

    private final LogoutUseCase logoutUseCase;

    @Override
    public void logout(
            HttpServletRequest request,
            HttpServletResponse response,
            Authentication authentication
    ) {
        if (authentication == null) {
            return;
        }

        UserPrincipal principal = (UserPrincipal) authentication.getPrincipal();

        logoutUseCase.execute(principal);
    }
}
