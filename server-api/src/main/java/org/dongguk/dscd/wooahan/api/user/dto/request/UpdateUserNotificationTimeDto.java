package org.dongguk.dscd.wooahan.api.user.dto.request;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonProperty;
import org.dongguk.dscd.wooahan.api.user.domain.type.ETime;

import java.time.LocalTime;

public record UpdateUserNotificationTimeDto (
        @JsonProperty("type")
        ETime type,
        @JsonProperty("time")
        @JsonFormat(pattern = "HH:mm")
        LocalTime time
) {
}
