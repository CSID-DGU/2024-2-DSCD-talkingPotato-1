package org.dongguk.dscd.wooahan.api.medication.domain.type;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum ETakenTime {

    BREAKFAST("아침", "Breakfast"),
    LUNCH("점심", "Lunch"),
    DINNER("저녁", "Dinner"),
    DAILY("하루", "Daily")
    ;

    private final String koName;
    private final String enName;
}
