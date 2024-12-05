package org.dongguk.dscd.wooahan.api.question.controller.query;

import lombok.RequiredArgsConstructor;
import org.dongguk.dscd.wooahan.api.core.annotation.common.AccountID;
import org.dongguk.dscd.wooahan.api.core.dto.ResponseDto;
import org.dongguk.dscd.wooahan.api.question.usecase.ReadQuestionListUseCase;
import org.dongguk.dscd.wooahan.api.question.usecase.ReadQuestionUseCase;
import org.dongguk.dscd.wooahan.api.question.usecase.ReadUserQuestionListUseCase;
import org.springframework.data.domain.Pageable;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;

@RestController
@RequiredArgsConstructor
@RequestMapping("/v1")
public class QuestionQueryV1Controller {

    private final ReadQuestionListUseCase readQuestionListUseCase;
    private final ReadQuestionUseCase readQuestionUseCase;
    private final ReadUserQuestionListUseCase readUserQuestionUseCase;

    /**
     * 9-1. 질문 목록 조회
     *
     * @param query 쿼리
     * @return 응답 DTO
     */
    @GetMapping("/questions")
    public ResponseDto<?> readQuestionList(
            @RequestParam(required = false, name = "q") String query,
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
    @GetMapping("/questions/{questionId}")
    public ResponseDto<?> readQuestion(@PathVariable Long questionId) {
        return ResponseDto.ok(readQuestionUseCase.execute(questionId));
    }

    /**
     * 9-5. 본인 질문 목록 조회
     * @param accountId 계정 ID
     * @return 응답 DTO
     */
    @PreAuthorize("hasRole('USER')")
    @GetMapping("/users/questions")
    public ResponseDto<?> readUserQuestionList(@AccountID UUID accountId) {
        return ResponseDto.ok(readUserQuestionUseCase.execute(accountId));
    }


}
