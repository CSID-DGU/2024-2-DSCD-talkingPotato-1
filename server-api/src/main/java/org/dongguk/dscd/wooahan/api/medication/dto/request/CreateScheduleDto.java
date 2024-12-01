package org.dongguk.dscd.wooahan.api.medication.dto.request;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.validation.constraints.NotNull;
import org.dongguk.dscd.wooahan.api.medication.domain.type.ETakenTime;

import java.time.LocalDate;

public record CreateScheduleDto(
        @JsonProperty("drug_id")
        @NotNull
        Integer drugId,
        @JsonProperty("time")
        @NotNull
        ETakenTime time,
        @JsonProperty("date")
        @JsonFormat(pattern = "yyyy-MM-dd")
        @NotNull
        LocalDate date
) {
}
