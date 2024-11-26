package org.dongguk.dscd.wooahan.api.question.dto.projection;

import java.time.LocalDateTime;
import java.util.UUID;

public interface ReadQuestionProjection {
    Long getId();
    String getContent();
    LocalDateTime getCreatedAt();
    Integer getAnswerCount();
    String getNickname();
    UUID getCreatorId();
}
