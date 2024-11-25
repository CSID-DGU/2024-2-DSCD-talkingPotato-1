package org.dongguk.dscd.wooahan.api.article.dto.projection;

import java.time.LocalDateTime;
import java.util.UUID;

public interface ReadCommentListProjection {
    Long getId();
    String getContent();
    LocalDateTime getCreatedAt();
    String getNickname();
    UUID getCreatorId();
}
