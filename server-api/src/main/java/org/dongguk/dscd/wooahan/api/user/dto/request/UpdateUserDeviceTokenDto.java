package org.dongguk.dscd.wooahan.api.user.dto.request;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.validation.constraints.NotNull;

public record UpdateUserDeviceTokenDto(

        @JsonProperty("device_token")
        @NotNull
        String deviceToken
) {
}
