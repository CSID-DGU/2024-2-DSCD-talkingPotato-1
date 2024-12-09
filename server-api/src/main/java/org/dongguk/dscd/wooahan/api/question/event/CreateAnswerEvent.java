package org.dongguk.dscd.wooahan.api.question.event;

import java.util.UUID;

public record CreateAnswerEvent(
        UUID userId
) {
}
