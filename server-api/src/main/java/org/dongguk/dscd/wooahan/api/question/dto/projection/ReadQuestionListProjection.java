package org.dongguk.dscd.wooahan.api.question.dto.projection;

import java.time.LocalDateTime;
import java.util.UUID;

public record ReadQuestionListProjection(
        Long id,
        String preview,
        String answerStatus,
        LocalDateTime createdAt,
        Long answerCount,
        String nickname,
        UUID creatorId
) {
}
