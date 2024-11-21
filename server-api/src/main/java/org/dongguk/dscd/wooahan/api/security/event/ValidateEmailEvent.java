package org.dongguk.dscd.wooahan.api.security.event;

import lombok.Builder;

@Builder
public record ValidateEmailEvent(
        String receiverAddress,
        String authenticationCode
) {
}
