package org.dongguk.dscd.wooahan.api.question.service;

import lombok.RequiredArgsConstructor;
import org.dongguk.dscd.wooahan.api.core.exception.error.ErrorCode;
import org.dongguk.dscd.wooahan.api.core.exception.type.CommonException;
import org.dongguk.dscd.wooahan.api.question.dto.projection.ReadAnswerListProjection;
import org.dongguk.dscd.wooahan.api.question.dto.response.ReadAnswerListDto;
import org.dongguk.dscd.wooahan.api.question.repository.mysql.AnswerRepository;
import org.dongguk.dscd.wooahan.api.question.repository.mysql.QuestionRepository;
import org.dongguk.dscd.wooahan.api.question.usecase.ReadAnswerListUseCase;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class ReadAnswerListService implements ReadAnswerListUseCase {

    private final QuestionRepository questionRepository;

    private final AnswerRepository answerRepository;
    @Override
    public ReadAnswerListDto execute(Long questionId) {
        questionRepository.findById(questionId)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_QUESTION));

        List<ReadAnswerListProjection> answers = answerRepository.findAllByQuestionIdWithDetail(questionId);

        return ReadAnswerListDto.builder()
                .answers(answers.stream()
                        .map(answer -> ReadAnswerListDto.ReadAnswerDto.builder()
                                .id(answer.getId())
                                .content(answer.getContent())
                                .createdAt(answer.getCreatedAt())
                                .nickname(answer.getNickname())
                                .creatorId(answer.getCreatorId())
                                .build())
                        .toList())
                .build();
    }
}
