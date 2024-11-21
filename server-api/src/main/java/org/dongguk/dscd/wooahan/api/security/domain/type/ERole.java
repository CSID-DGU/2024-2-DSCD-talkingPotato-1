package org.dongguk.dscd.wooahan.api.security.domain.type;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum ERole {

    ADMIN("관리자", "ADMIN", "ROLE_ADMIN"),
    EXPERT("전문가", "EXPERT", "ROLE_EXPERT"),
    USER("사용자", "USER", "ROLE_USER"),

    ;

    private final String koName;
    private final String enName;
    private final String securityName;

    public static ERole fromString(String value) {
        return switch (value.toUpperCase()) {
            case "ADMIN" -> ADMIN;
            case "USER" -> USER;
            case "EXPERT" -> EXPERT;
            default -> throw new IllegalArgumentException("Unknown value: " + value);
        };
    }
}
