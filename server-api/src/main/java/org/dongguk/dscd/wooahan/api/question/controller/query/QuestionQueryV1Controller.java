package org.dongguk.dscd.wooahan.api.question.controller.query;

import lombok.RequiredArgsConstructor;
import org.dongguk.dscd.wooahan.api.core.dto.ResponseDto;
import org.dongguk.dscd.wooahan.api.question.usecase.ReadQuestionListUseCase;
import org.dongguk.dscd.wooahan.api.question.usecase.ReadQuestionUseCase;
import org.springframework.data.domain.Pageable;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("/v1/questions")
public class QuestionQueryV1Controller {

    private final ReadQuestionListUseCase readQuestionListUseCase;
    private final ReadQuestionUseCase readQuestionUseCase;

    /**
     * 9-1. 질문 목록 조회
     *
     * @param query 쿼리
     * @return 응답 DTO
     */
    @GetMapping
    public ResponseDto<?> readQuestionList(
            @RequestParam(required = false) String query,
            Pageable pageable
    ) {
        return ResponseDto.ok(readQuestionListUseCase.execute(query, pageable));
    }

    /**
     * 9-2. 질문 단일 조회
     *
     * @param questionId 질문 ID
     * @return 응답 DTO
     */
    @GetMapping("/{questionId}")
    public ResponseDto<?> readQuestion(@PathVariable Long questionId) {
        return ResponseDto.ok(readQuestionUseCase.execute(questionId));
    }
}
