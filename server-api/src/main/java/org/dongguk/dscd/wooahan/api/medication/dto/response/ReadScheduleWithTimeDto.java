package org.dongguk.dscd.wooahan.api.medication.dto.response;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Builder;

import java.util.List;

@Builder
public record ReadScheduleWithTimeDto(
        @JsonProperty("drugs")
        List<ReadScheduleDto> drugs
) {

    @Builder
    public record ReadScheduleDto(
            @JsonProperty("drug_id")
            Integer drugId,
            @JsonProperty("is_taken")
            Boolean isTaken
    ) {
    }
}
