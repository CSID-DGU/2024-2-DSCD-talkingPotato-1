package org.dongguk.dscd.wooahan.api.question.dto.response;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Builder;

import java.time.LocalDateTime;
import java.util.UUID;

@Builder
public record ReadQuestionDto (
        @JsonProperty("id")
        Long id,
        @JsonProperty("content")
        String content,
        @JsonProperty("created_at")
        @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
        LocalDateTime createdAt,
        @JsonProperty("answer_count")
        Integer answerCount,
        @JsonProperty("nickname")
        String nickname,
        @JsonProperty("creator_id")
        UUID creatorId
) {
}
