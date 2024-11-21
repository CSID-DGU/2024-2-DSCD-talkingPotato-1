package org.dongguk.dscd.wooahan.api.security.dto.response;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.validation.constraints.NotBlank;
import lombok.Builder;

@Builder
public record DefaultJsonWebTokenDto(
        @JsonProperty("access_token")
        @NotBlank
        String accessToken,

        @JsonProperty("refresh_token")
        @NotBlank
        String refreshToken
) {
}
