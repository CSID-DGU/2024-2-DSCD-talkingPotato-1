package org.dongguk.dscd.wooahan.api.question.usecase;

import org.dongguk.dscd.wooahan.api.question.dto.request.CreateQuestionRequestDto;

import java.util.UUID;

public interface CreateQuestionUseCase {
    /**
     * 질문 생성
     * @param accountId 계정 ID
     * @param requestDto 질문 생성 DTO
     */
    void execute(
            UUID accountId,
            CreateQuestionRequestDto requestDto
    );
}
