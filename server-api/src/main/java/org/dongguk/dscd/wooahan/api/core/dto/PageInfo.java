package org.dongguk.dscd.wooahan.api.core.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Builder;
import org.springframework.data.domain.Page;

@Builder
public record PageInfo(
        @JsonProperty("total_page")
        Integer totalPage,

        @JsonProperty("current_page")
        Integer currentPage,

        @JsonProperty("total_cnt")
        Integer totalCnt,

        @JsonProperty("current_cnt")
        Integer currentCnt
) {
    public static PageInfo fromPage(Page<?> postPage) {
        return PageInfo.builder()
                .totalPage(postPage.getTotalPages())
                .currentPage(postPage.getTotalPages() == 0 ? 0 : postPage.getNumber() + 1)
                .totalCnt((int) postPage.getTotalElements())
                .currentCnt(postPage.getNumberOfElements())
                .build();
    }
}
