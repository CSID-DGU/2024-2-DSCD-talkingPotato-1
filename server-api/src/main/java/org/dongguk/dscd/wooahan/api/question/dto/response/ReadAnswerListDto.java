package org.dongguk.dscd.wooahan.api.question.dto.response;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Builder;

import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

@Builder
public record ReadAnswerListDto (
        @JsonProperty("answers")
        List<ReadAnswerDto> answers
) {
        @Builder
        public record ReadAnswerDto (
                @JsonProperty("id")
                Long id,
                @JsonProperty("content")
                String content,
                @JsonProperty("created_at")
                @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
                LocalDateTime createdAt,
                @JsonProperty("nickname")
                String nickname,
                @JsonProperty("creator_id")
                UUID creatorId
        ) {
        }
}