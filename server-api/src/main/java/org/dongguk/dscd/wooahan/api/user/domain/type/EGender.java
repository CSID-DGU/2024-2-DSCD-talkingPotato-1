package org.dongguk.dscd.wooahan.api.user.domain.type;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum EGender {

    MALE("남성", "Male"),
    FEMALE("여성", "Female"),

    ;

    private final String koName;
    private final String enName;
}

