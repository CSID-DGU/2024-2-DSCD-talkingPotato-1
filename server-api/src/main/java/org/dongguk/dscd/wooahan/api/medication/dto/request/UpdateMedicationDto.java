package org.dongguk.dscd.wooahan.api.medication.dto.request;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.validation.constraints.NotNull;

import java.util.List;

public record UpdateMedicationDto(
        @JsonProperty("medications")
        List<MedicationDto> medications
) {

    public record MedicationDto(
            @JsonProperty("drug_id")
            @NotNull
            Integer drugId,
            @JsonProperty("is_taken_in_breakfast")
            @NotNull
            Boolean isTakenInBreakfast,
            @JsonProperty("is_taken_in_lunch")
            @NotNull
            Boolean isTakenInLunch,
            @JsonProperty("is_taken_in_dinner")
            @NotNull
            Boolean isTakenInDinner,
            @JsonProperty("is_taken_in_daily")
            @NotNull
            Boolean isTakenInDaily
    ) {
    }
}
