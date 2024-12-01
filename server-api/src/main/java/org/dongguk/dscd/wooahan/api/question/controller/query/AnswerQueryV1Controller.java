package org.dongguk.dscd.wooahan.api.question.controller.query;

import lombok.RequiredArgsConstructor;
import org.dongguk.dscd.wooahan.api.core.dto.ResponseDto;
import org.dongguk.dscd.wooahan.api.question.usecase.ReadAnswerListUseCase;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
@RequestMapping("/v1")
public class AnswerQueryV1Controller {

    private final ReadAnswerListUseCase readAnswerListUseCase;

    /**
     * 10-2. 답변 목록 조회
     *
     * @param questionId 질문 ID
     * @return 응답 DTO
     */
    @GetMapping("/questions/{questionId}/answers")
    public ResponseDto<?> readAnswerList(@PathVariable Long questionId) {
        return ResponseDto.ok(readAnswerListUseCase.execute(questionId));
    }
}
