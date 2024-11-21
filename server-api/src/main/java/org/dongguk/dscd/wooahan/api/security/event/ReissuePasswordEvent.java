package org.dongguk.dscd.wooahan.api.security.event;

import lombok.Builder;

@Builder
public record ReissuePasswordEvent(
        String receiverAddress,
        String temporaryPassword
) {
}
