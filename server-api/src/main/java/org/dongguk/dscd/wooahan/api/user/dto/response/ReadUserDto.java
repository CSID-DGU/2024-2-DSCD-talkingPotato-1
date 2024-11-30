package org.dongguk.dscd.wooahan.api.user.dto.response;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Builder;

import java.time.LocalTime;
import java.util.UUID;

@Builder
public record ReadUserDto (
        @JsonProperty("id")
        UUID id,
        @JsonProperty("nickname")
        String nickname,
        @JsonProperty("is_allowed_notification")
        Boolean isAllowedNotification,
        @JsonProperty("breakfast_time")
        @JsonFormat(pattern = "HH:mm")
        LocalTime breakfastTime,
        @JsonProperty("lunch_time")
        @JsonFormat(pattern = "HH:mm")
        LocalTime lunchTime,
        @JsonProperty("dinner_time")
        @JsonFormat(pattern = "HH:mm")
        LocalTime dinnerTime,
        @JsonProperty("is_validated_pass")
        Boolean isValidatedPass

) {
}
