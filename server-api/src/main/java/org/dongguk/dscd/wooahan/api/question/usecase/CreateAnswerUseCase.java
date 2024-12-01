package org.dongguk.dscd.wooahan.api.question.usecase;

import org.dongguk.dscd.wooahan.api.question.dto.request.CreateAnswerDto;

import java.util.UUID;

public interface CreateAnswerUseCase {
    /**
     * 답변 생성
     * @param accountId 계정 ID
     * @param questionId 질문 ID
     * @param requestDto 답변 생성 DTO
     */
    void execute(
            UUID accountId,
            Long questionId,
            CreateAnswerDto requestDto
    );
}
