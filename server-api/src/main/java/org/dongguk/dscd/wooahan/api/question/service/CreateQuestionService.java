package org.dongguk.dscd.wooahan.api.question.service;

import lombok.RequiredArgsConstructor;
import org.dongguk.dscd.wooahan.api.core.exception.error.ErrorCode;
import org.dongguk.dscd.wooahan.api.core.exception.type.CommonException;
import org.dongguk.dscd.wooahan.api.core.scheduler.UpdaterScheduler;
import org.dongguk.dscd.wooahan.api.question.domain.mysql.Question;
import org.dongguk.dscd.wooahan.api.question.dto.request.CreateQuestionRequestDto;
import org.dongguk.dscd.wooahan.api.question.event.CreateQuestionEvent;
import org.dongguk.dscd.wooahan.api.question.repository.mysql.QuestionRepository;
import org.dongguk.dscd.wooahan.api.question.usecase.CreateQuestionUseCase;
import org.dongguk.dscd.wooahan.api.user.domain.mysql.User;
import org.dongguk.dscd.wooahan.api.user.repository.mysql.UserRepository;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.stereotype.Service;

import java.time.ZoneId;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class CreateQuestionService implements CreateQuestionUseCase {

    private final QuestionRepository questionRepository;
    private final UserRepository userRepository;

    private final UpdaterScheduler updaterScheduler;

    private final ApplicationEventPublisher applicationEventPublisher;

    @Override
    public void execute(
            UUID accountId,
            CreateQuestionRequestDto requestDto
    ) {
        User user = userRepository.findById(accountId)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        Question question = Question.builder()
                .creator(user)
                .content(requestDto.content())
                .build();

        questionRepository.save(question);

        updaterScheduler.addQuestionTask(
                question.getId(),
                () -> {
                    applicationEventPublisher.publishEvent(CreateQuestionEvent.builder()
                            .questionId(question.getId())
                            .content(question.getContent())
                            .build());
                },
                question.getCreatedAt().plusMinutes(1).atZone(ZoneId.systemDefault()).toInstant()
        );
    }
}
