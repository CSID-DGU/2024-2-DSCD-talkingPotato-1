package org.dongguk.dscd.wooahan.api.question.dto.request;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.validation.constraints.NotBlank;

public record CreateQuestionRequestDto(
        @JsonProperty("content")
        @NotBlank
        String content
) {
}
