package org.dongguk.dscd.wooahan.api.security.dto.response;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.validation.constraints.NotBlank;
import lombok.Builder;

@Builder
public record TemporaryJsonWebTokenDto(
        @JsonProperty("temporary_token")
        @NotBlank
        String temporaryToken
) {
}
