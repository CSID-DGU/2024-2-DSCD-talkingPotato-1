package org.dongguk.dscd.wooahan.api.medication.dto.response;

import lombok.Builder;

@Builder
public record ReadScheduleSummaryDto(
        ReadSummaryDto breakfast,
        ReadSummaryDto lunch,
        ReadSummaryDto dinner,
        ReadSummaryDto daily
) {

    @Builder
    public record ReadSummaryDto(
            Integer totalDrugCount,
            Integer takenDrugCount
    ) {
    }
}
