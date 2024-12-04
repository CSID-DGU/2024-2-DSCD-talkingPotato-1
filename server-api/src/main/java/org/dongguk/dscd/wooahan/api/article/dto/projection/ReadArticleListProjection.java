package org.dongguk.dscd.wooahan.api.article.dto.projection;

import java.time.LocalDateTime;
import java.util.UUID;

public record ReadArticleListProjection (
        Long id,
        String title,
        String preview,
        LocalDateTime createdAt,
        String nickname,
        UUID creatorId,
        Long commentCnt,
        String tags
) {
}