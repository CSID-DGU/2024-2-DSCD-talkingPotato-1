package org.dongguk.dscd.wooahan.api.article.dto.response;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Builder;

import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

@Builder
public record ReadArticleListDto (
        @JsonProperty("articles")
        List<ReadArticleDto> articles
) {

    @Builder
    public record ReadArticleDto (

            @JsonProperty("id")
            Long id,

            @JsonProperty("title")
            String title,

            @JsonProperty("preview")
            String preview,

            @JsonProperty("tags")
            List<String> tags,

            @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
            @JsonProperty("created_at")
            LocalDateTime createdAt,

            @JsonProperty("comment_cnt")
            Long commentCnt,

            @JsonProperty("nickname")
            String nickname,

            @JsonProperty("creator_id")
            UUID creatorId,

            @JsonProperty("thumbnail_url")
            String thumbnailUrl
    ) {
    }
}
