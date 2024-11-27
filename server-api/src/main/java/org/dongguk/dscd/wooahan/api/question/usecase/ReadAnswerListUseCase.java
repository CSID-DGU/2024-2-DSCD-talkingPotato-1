package org.dongguk.dscd.wooahan.api.question.usecase;

import org.dongguk.dscd.wooahan.api.question.dto.response.ReadAnswerListDto;

public interface ReadAnswerListUseCase {
    /**
     * 답변 목록 조회
     * @param questionId 질문 ID
     */
    ReadAnswerListDto execute(Long questionId);
}
