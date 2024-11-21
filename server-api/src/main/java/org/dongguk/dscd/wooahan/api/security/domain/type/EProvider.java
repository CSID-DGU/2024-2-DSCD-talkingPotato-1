package org.dongguk.dscd.wooahan.api.security.domain.type;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum EProvider {

    DEFAULT("기본", "Default"),

    ;

    private final String koName;
    private final String enName;

    public static EProvider fromString(String value) {
        return switch (value.toUpperCase()) {
            case "DEFAULT" -> DEFAULT;
            default -> throw new IllegalArgumentException("Provider가 잘못되었습니다.");
        };
    }
}
