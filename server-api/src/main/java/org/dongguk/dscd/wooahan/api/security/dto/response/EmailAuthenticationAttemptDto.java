package org.dongguk.dscd.wooahan.api.security.dto.response;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Builder;
import org.dongguk.dscd.wooahan.api.security.domain.redis.AuthenticationCodeHistory;

@Builder
public record EmailAuthenticationAttemptDto(
        @JsonProperty(namespace = "try_cnt")
        Integer tryCnt
) {

    public static EmailAuthenticationAttemptDto fromEntity(AuthenticationCodeHistory entity) {
        return EmailAuthenticationAttemptDto.builder()
                .tryCnt(entity.getCount())
                .build();
    }
}
