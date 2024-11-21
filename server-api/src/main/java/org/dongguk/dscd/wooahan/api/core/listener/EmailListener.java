package org.dongguk.dscd.wooahan.api.core.listener;

import lombok.RequiredArgsConstructor;
import org.dongguk.dscd.wooahan.api.core.utility.EmailUtil;
import org.dongguk.dscd.wooahan.api.security.event.ReissuePasswordEvent;
import org.dongguk.dscd.wooahan.api.security.event.ValidateEmailEvent;
import org.springframework.context.event.EventListener;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class EmailListener {

    private final EmailUtil emailUtil;

    @Async
    @EventListener(classes = {ValidateEmailEvent.class})
    public void handleCompleteEmailValidationEvent(ValidateEmailEvent event) {

        try {
            emailUtil.sendAuthenticationCode(
                    event.receiverAddress(),
                    event.authenticationCode()
            );
        } catch (Exception ignored) {
        }
    }

    @Async
    @EventListener(classes = {ReissuePasswordEvent.class})
    public void handleChangePasswordBySystemEvent(ReissuePasswordEvent event) {

        try {
            emailUtil.sendTemporaryPassword(
                    event.receiverAddress(),
                    event.temporaryPassword()
            );
        } catch (Exception ignored) {
        }
    }
}
