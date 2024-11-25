package org.dongguk.dscd.wooahan.api.article.dto.request;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.validation.constraints.NotBlank;

import java.util.List;

public record CreateArticleDto (
        @JsonProperty("title")
        @NotBlank(message = "제목을 입력해주세요.")
        String title,
        @JsonProperty("tags")
        List<String> tags,
        @JsonProperty("content")
        @NotBlank(message = "내용을 입력해주세요.")
        String content
) {
}
