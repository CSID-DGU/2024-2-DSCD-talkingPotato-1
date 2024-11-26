package org.dongguk.dscd.wooahan.api.question.usecase;

import org.dongguk.dscd.wooahan.api.question.dto.response.ReadQuestionListDto;
import org.springframework.data.domain.Pageable;

public interface ReadQuestionListUseCase {
    /**
     * 질문 목록 조회
     * @param query 쿼리
     * @param pageable 페이지 정보
     */
    ReadQuestionListDto execute(
            String query,
            Pageable pageable
    );
}
