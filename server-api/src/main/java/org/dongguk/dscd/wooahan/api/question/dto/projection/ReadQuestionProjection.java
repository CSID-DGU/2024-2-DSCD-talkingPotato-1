package org.dongguk.dscd.wooahan.api.question.dto.projection;

import java.time.LocalDateTime;

public interface ReadQuestionProjection {
    Long getId();
    String getContent();
    LocalDateTime getCreatedAt();
    Integer getAnswerCount();
    String getNickname();
    String getCreatorId();
}
