package org.dongguk.dscd.wooahan.api.article.dto.request;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.validation.constraints.NotBlank;

import java.util.List;

public record UpdateArticleDto (
        @JsonProperty("title")
        @NotBlank(message = "제목을 입력해주세요.")
        String title,
        @JsonProperty("content")
        @NotBlank(message = "내용을 입력해주세요.")
        String content,
        @JsonProperty("tags")
        List<String> tags
) {
}
