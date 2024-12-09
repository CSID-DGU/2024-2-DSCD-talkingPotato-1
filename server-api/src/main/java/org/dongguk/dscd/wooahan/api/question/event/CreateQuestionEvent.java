package org.dongguk.dscd.wooahan.api.question.event;

import lombok.Builder;

@Builder
public record CreateQuestionEvent(
        Long questionId,
        String content
) {
}
