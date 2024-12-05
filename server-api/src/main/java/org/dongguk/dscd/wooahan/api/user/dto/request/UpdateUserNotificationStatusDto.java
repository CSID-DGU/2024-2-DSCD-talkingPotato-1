package org.dongguk.dscd.wooahan.api.user.dto.request;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.validation.constraints.NotNull;

public record UpdateUserNotificationStatusDto(

        @JsonProperty("is_allowed_notification")
        @NotNull
        Boolean isAllowedNotification
) {
}
