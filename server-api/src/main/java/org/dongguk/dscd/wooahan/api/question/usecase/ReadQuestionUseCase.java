package org.dongguk.dscd.wooahan.api.question.usecase;

import org.dongguk.dscd.wooahan.api.question.dto.response.ReadQuestionDto;

public interface ReadQuestionUseCase {
    /**
     * 질문 단일 조회
     * @param questionId 질문 ID
     */
    ReadQuestionDto execute(Long questionId);
}
