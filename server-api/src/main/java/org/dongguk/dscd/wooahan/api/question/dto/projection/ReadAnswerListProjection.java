package org.dongguk.dscd.wooahan.api.question.dto.projection;

import java.time.LocalDateTime;
import java.util.UUID;

public interface ReadAnswerListProjection {
    Long getId();
    String getContent();
    LocalDateTime getCreatedAt();
    String getNickname();
    UUID getCreatorId();

}
