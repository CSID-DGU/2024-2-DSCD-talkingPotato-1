package org.dongguk.dscd.wooahan.api.question.service;

import lombok.RequiredArgsConstructor;
import org.dongguk.dscd.wooahan.api.core.exception.error.ErrorCode;
import org.dongguk.dscd.wooahan.api.core.exception.type.CommonException;
import org.dongguk.dscd.wooahan.api.core.scheduler.UpdaterScheduler;
import org.dongguk.dscd.wooahan.api.question.domain.mysql.Question;
import org.dongguk.dscd.wooahan.api.question.repository.mysql.QuestionRepository;
import org.dongguk.dscd.wooahan.api.question.usecase.DeleteQuestionUseCase;
import org.springframework.stereotype.Service;

import java.util.UUID;

@Service
@RequiredArgsConstructor
public class DeleteQuestionService implements DeleteQuestionUseCase {

    private final QuestionRepository questionRepository;

    private final UpdaterScheduler updaterScheduler;

    @Override
    public void execute(
            UUID accountId,
            Long questionId
    ) {
       Question question = questionRepository.findById(questionId)
               .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_QUESTION));

       if (!question.getCreator().getId().equals(accountId)) {
           throw new CommonException(ErrorCode.ACCESS_DENIED_QUESTION);
       }

       questionRepository.delete(question);

         updaterScheduler.removeQuestionTask(questionId);
    }
}
