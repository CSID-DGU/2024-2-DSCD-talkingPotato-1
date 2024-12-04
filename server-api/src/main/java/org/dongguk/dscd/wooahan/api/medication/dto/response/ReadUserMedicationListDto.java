package org.dongguk.dscd.wooahan.api.medication.dto.response;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Builder;

import java.util.List;

@Builder
public record ReadUserMedicationListDto(
        @JsonProperty("drugs")
        List<UserMedicationDto> medications
) {

    @Builder
    public record UserMedicationDto (
            @JsonProperty("drug_id")
            Integer drugId,
            @JsonProperty("is_taken_in_breakfast")
            Boolean isTakenInBreakfast,
            @JsonProperty("is_taken_in_lunch")
            Boolean isTakenInLunch,
            @JsonProperty("is_taken_in_dinner")
            Boolean isTakenInDinner,
            @JsonProperty("is_taken_in_daily")
            Boolean isTakenInDaily
    ) {
    }

}
