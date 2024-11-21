package org.dongguk.dscd.wooahan.api.security.domain.redis;

import jakarta.persistence.Column;
import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.Id;
import org.springframework.data.redis.core.RedisHash;

@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@RedisHash(value = "temporary_token", timeToLive = 60 * 15)
public class TemporaryToken {
    @Id
    @Column(name = "email")
    private String email;

    @Column(name = "value")
    private String value;

    @Builder
    public TemporaryToken(String email, String value) {
        this.email = email;
        this.value = value;
    }
}
