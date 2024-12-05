package org.dongguk.dscd.wooahan.api.question.usecase;

import org.dongguk.dscd.wooahan.api.question.dto.response.ReadUserQuestionListDto;

import java.util.UUID;

public interface ReadUserQuestionListUseCase {
    ReadUserQuestionListDto execute(UUID accountId);
}
