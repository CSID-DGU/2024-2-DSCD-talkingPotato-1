package org.dongguk.dscd.wooahan.api.question.usecase;

import java.util.UUID;

public interface DeleteAnswerUseCase {
    /**
     * 답변 삭제
     * @param accountId 계정 ID
     * @param answerId 답변 ID
     */
    void execute(
            UUID accountId,
            Long answerId
    );
}
