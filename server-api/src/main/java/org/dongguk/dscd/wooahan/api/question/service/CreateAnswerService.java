package org.dongguk.dscd.wooahan.api.question.service;

import lombok.RequiredArgsConstructor;
import org.dongguk.dscd.wooahan.api.core.exception.error.ErrorCode;
import org.dongguk.dscd.wooahan.api.core.exception.type.CommonException;
import org.dongguk.dscd.wooahan.api.core.scheduler.UpdaterScheduler;
import org.dongguk.dscd.wooahan.api.expert.domain.mysql.Expert;
import org.dongguk.dscd.wooahan.api.expert.repository.ExpertRepository;
import org.dongguk.dscd.wooahan.api.question.domain.mysql.Answer;
import org.dongguk.dscd.wooahan.api.question.domain.mysql.Question;
import org.dongguk.dscd.wooahan.api.question.dto.request.CreateAnswerDto;
import org.dongguk.dscd.wooahan.api.question.repository.mysql.AnswerRepository;
import org.dongguk.dscd.wooahan.api.question.repository.mysql.QuestionRepository;
import org.dongguk.dscd.wooahan.api.question.usecase.CreateAnswerUseCase;
import org.springframework.stereotype.Service;

import java.util.UUID;

@Service
@RequiredArgsConstructor
public class CreateAnswerService implements CreateAnswerUseCase {

    private final QuestionRepository questionRepository;

    private final AnswerRepository answerRepository;

    private final ExpertRepository expertRepository;

    private final UpdaterScheduler updaterScheduler;

    @Override
    public void execute(
            UUID accountId,
            Long questionId,
            CreateAnswerDto requestDto
    ) {
        Expert expert = expertRepository.findById(accountId)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_EXPERT));

        Question question = questionRepository.findById(questionId)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_QUESTION));

        Answer answer = Answer.builder()
                .creator(expert)
                .question(question)
                .content(requestDto.content())
                .build();

        answerRepository.save(answer);

        updaterScheduler.removeQuestionTask(questionId);
    }
}
