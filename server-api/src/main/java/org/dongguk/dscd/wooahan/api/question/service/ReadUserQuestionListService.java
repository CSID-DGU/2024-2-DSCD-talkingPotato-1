package org.dongguk.dscd.wooahan.api.question.service;

import lombok.RequiredArgsConstructor;
import org.dongguk.dscd.wooahan.api.question.dto.projection.ReadUserQuestionListProjection;
import org.dongguk.dscd.wooahan.api.question.dto.response.ReadUserQuestionListDto;
import org.dongguk.dscd.wooahan.api.question.repository.mysql.QuestionRepository;
import org.dongguk.dscd.wooahan.api.question.usecase.ReadUserQuestionListUseCase;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class ReadUserQuestionListService implements ReadUserQuestionListUseCase {

    private final QuestionRepository questionRepository;

    @Override
    public ReadUserQuestionListDto execute(UUID accountId) {
        List<ReadUserQuestionListProjection> questionList = questionRepository.findUserQuestionList(accountId);

        return ReadUserQuestionListDto.builder()
                .questions(
                        questionList.stream()
                                .map(question -> ReadUserQuestionListDto.ReadQuestionDto.builder()
                                        .id(question.id())
                                        .preview(question.preview())
                                        .createdAt(question.createdAt())
                                        .answerStatus(question.answerStatus())
                                        .answerCount(question.answerCount())
                                        .creatorId(question.creatorId())
                                        .nickname(question.nickname())
                                        .build()
                                )
                                .toList()
                )
                .build();
    }
}
