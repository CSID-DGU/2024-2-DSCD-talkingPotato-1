package org.dongguk.dscd.wooahan.api.question.service;

import lombok.RequiredArgsConstructor;
import org.dongguk.dscd.wooahan.api.core.exception.error.ErrorCode;
import org.dongguk.dscd.wooahan.api.core.exception.type.CommonException;
import org.dongguk.dscd.wooahan.api.question.domain.mysql.Answer;
import org.dongguk.dscd.wooahan.api.question.repository.mysql.AnswerRepository;
import org.dongguk.dscd.wooahan.api.question.usecase.DeleteAnswerUseCase;
import org.springframework.stereotype.Service;

import java.util.UUID;

@Service
@RequiredArgsConstructor
public class DeleteAnswerService implements DeleteAnswerUseCase {

    private final AnswerRepository answerRepository;
    @Override
    public void execute(
            UUID accountId,
            Long answerId
    ) {
        Answer answer = answerRepository.findById(answerId)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_ANSWER));

        if (!answer.getCreator().getId().equals(accountId)) {
            throw new CommonException(ErrorCode.ACCESS_DENIED_ANSWER);
        }

        answerRepository.delete(answer);
    }
}
