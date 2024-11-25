package org.dongguk.dscd.wooahan.api.article.dto.projection;

import java.time.LocalDateTime;
import java.util.UUID;

public interface ReadArticleProjection {
    Long getId();
    String getTitle();
    String getContent();
    LocalDateTime getCreatedAt();
    String getNickname();
    UUID getCreatorId();
    Integer getCommentCnt();
    String getTags();
}
