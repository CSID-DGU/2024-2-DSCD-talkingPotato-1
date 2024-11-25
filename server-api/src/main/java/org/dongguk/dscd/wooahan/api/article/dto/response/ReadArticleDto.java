package org.dongguk.dscd.wooahan.api.article.dto.response;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Builder;

import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

@Builder
public record ReadArticleDto (
        @JsonProperty("id")
        Long id,
        @JsonProperty("title")
        String title,
        @JsonProperty("content")
        String content,
        @JsonProperty("tags")
        List<String> tags,
        @JsonProperty("created_at")
        @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
        LocalDateTime createdAt,
        @JsonProperty("comment_cnt")
        Integer commentCnt,
        @JsonProperty("nickname")
        String nickname,
        @JsonProperty("creator_id")
        UUID creatorId
) {
}
