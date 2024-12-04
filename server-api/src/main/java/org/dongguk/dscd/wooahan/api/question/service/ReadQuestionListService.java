package org.dongguk.dscd.wooahan.api.question.service;

import lombok.RequiredArgsConstructor;
import org.dongguk.dscd.wooahan.api.question.dto.projection.ReadQuestionListProjection;
import org.dongguk.dscd.wooahan.api.question.dto.response.ReadQuestionListDto;
import org.dongguk.dscd.wooahan.api.question.repository.mysql.QuestionRepository;
import org.dongguk.dscd.wooahan.api.question.usecase.ReadQuestionListUseCase;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class ReadQuestionListService implements ReadQuestionListUseCase {

    private final QuestionRepository questionRepository;

    @Override
    public ReadQuestionListDto execute(
            String query,
            Pageable pageable
    ) {
        List<ReadQuestionListProjection> questionList = questionRepository.findQuestionList(query, pageable);

        return ReadQuestionListDto.builder()
                .questions(
                        questionList.stream()
                                .map(question -> ReadQuestionListDto.ReadQuestionDto.builder()
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
