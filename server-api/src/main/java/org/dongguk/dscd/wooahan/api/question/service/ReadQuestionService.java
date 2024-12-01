package org.dongguk.dscd.wooahan.api.question.service;

import lombok.RequiredArgsConstructor;
import org.dongguk.dscd.wooahan.api.core.exception.error.ErrorCode;
import org.dongguk.dscd.wooahan.api.core.exception.type.CommonException;
import org.dongguk.dscd.wooahan.api.question.dto.projection.ReadQuestionProjection;
import org.dongguk.dscd.wooahan.api.question.dto.response.ReadQuestionDto;
import org.dongguk.dscd.wooahan.api.question.repository.mysql.QuestionRepository;
import org.dongguk.dscd.wooahan.api.question.usecase.ReadQuestionUseCase;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class ReadQuestionService implements ReadQuestionUseCase {

    private final QuestionRepository questionRepository;

    @Override
    public ReadQuestionDto execute(Long questionId) {
         ReadQuestionProjection question = questionRepository.findByIdWithDetail(questionId)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_QUESTION));

         return ReadQuestionDto.builder()
                 .id(question.getId())
                 .content(question.getContent())
                 .createdAt(question.getCreatedAt())
                 .answerCount(question.getAnswerCount())
                 .nickname(question.getNickname())
                 .creatorId(question.getCreatorId())
                 .build();
    }
}
