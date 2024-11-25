package org.dongguk.dscd.wooahan.api.article.dto.request;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.validation.constraints.NotBlank;

public record CreateCommentDto (
        @JsonProperty("content")
        @NotBlank(message = "내용을 입력해주세요.")
        String content
) {
}
