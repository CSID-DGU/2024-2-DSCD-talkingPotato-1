package org.dongguk.dscd.wooahan.api.question.dto.projection;

import java.time.LocalDateTime;

public interface ReadQuestionListProjection {
    Long getId();
    String getPreview();
    String getAnswerStatus();
    LocalDateTime getCreatedAt();
    Integer getAnswerCount();
    String getNickname();
    String getCreatorId();
}
