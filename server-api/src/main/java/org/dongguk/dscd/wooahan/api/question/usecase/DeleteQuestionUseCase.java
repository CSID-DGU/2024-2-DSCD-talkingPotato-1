package org.dongguk.dscd.wooahan.api.question.usecase;

import java.util.UUID;

public interface DeleteQuestionUseCase {
    /**
     * 질문 삭제
     * @param accountId 계정 ID
     * @param questionId 질문 ID
     */
    void execute(
            UUID accountId,
            Long questionId
    );
}
