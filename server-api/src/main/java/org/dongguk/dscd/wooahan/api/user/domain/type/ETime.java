package org.dongguk.dscd.wooahan.api.user.domain.type;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum ETime {
    BREAKFAST("아침", "Breakfast"),
    LUNCH("점심", "Lunch"),
    DINNER("저녁", "Dinner"),

    ;

    private final String koName;
    private final String enName;
}
