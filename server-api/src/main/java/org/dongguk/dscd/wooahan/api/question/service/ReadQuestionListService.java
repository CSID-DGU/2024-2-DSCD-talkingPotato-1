package org.dongguk.dscd.wooahan.api.question.service;

import lombok.RequiredArgsConstructor;
import org.dongguk.dscd.wooahan.api.question.dto.projection.ReadQuestionListProjection;
import org.dongguk.dscd.wooahan.api.question.dto.response.ReadQuestionListDto;
import org.dongguk.dscd.wooahan.api.question.repository.mysql.QuestionRepository;
import org.dongguk.dscd.wooahan.api.question.usecase.ReadQuestionListUseCase;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class ReadQuestionListService implements ReadQuestionListUseCase {

    private final QuestionRepository questionRepository;

    @Override
    public ReadQuestionListDto execute(
            String query,
            Pageable pageable
    ) {
        // TODO: query를 이용한 검색 기능 구현
        Page<ReadQuestionListProjection> questions = questionRepository.findAllWithDetail(pageable);

        return ReadQuestionListDto.builder()
                .questions(questions.stream()
                        .map(question -> ReadQuestionListDto.ReadQuestionDto.builder()
                                .id(question.getId())
                                .preview(question.getPreview())
                                .createdAt(question.getCreatedAt())
                                .answerStatus(question.getAnswerStatus())
                                .answerCount(question.getAnswerCount())
                                .nickname(question.getNickname())
                                .creatorId(question.getCreatorId())
                                .build())
                        .toList())
                .build();
    }
}
