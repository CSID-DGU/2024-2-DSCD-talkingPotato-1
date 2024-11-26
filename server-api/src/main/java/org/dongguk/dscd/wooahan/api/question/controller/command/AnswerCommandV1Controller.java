package org.dongguk.dscd.wooahan.api.question.controller.command;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.dongguk.dscd.wooahan.api.core.annotation.common.AccountID;
import org.dongguk.dscd.wooahan.api.core.dto.ResponseDto;
import org.dongguk.dscd.wooahan.api.question.dto.request.CreateAnswerDto;
import org.dongguk.dscd.wooahan.api.question.usecase.CreateAnswerUseCase;
import org.dongguk.dscd.wooahan.api.question.usecase.DeleteAnswerUseCase;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;

@RestController
@RequiredArgsConstructor
@RequestMapping("/v1")
public class AnswerCommandV1Controller {

    private final CreateAnswerUseCase createAnswerUseCase;
    private final DeleteAnswerUseCase  deleteAnswerUseCase;

    /**
     * 10-1. 답변 생성
     *
     * @param accountId 계정 ID
     * @param questionId 질문 ID
     * @param requestDto 답변 생성 DTO
     * @return 응답 DTO
     */
    @PreAuthorize("hasRole('EXPERT')")
    @PostMapping("/questions/{questionId}/answers")
    public ResponseDto<?> createAnswer(
            @AccountID UUID accountId,
            @PathVariable Long questionId,
            @RequestBody @Valid CreateAnswerDto requestDto
    ) {
        createAnswerUseCase.execute(accountId, questionId, requestDto);

        return ResponseDto.ok(null);
    }

    /**
     * 10-3. 답변 삭제
     *
     * @param accountId 계정 ID
     * @param answerId 답변 ID
     * @return 응답 DTO
     */
    @PreAuthorize("hasRole('EXPERT')")
    @DeleteMapping("/answers/{answerId}")
    public ResponseDto<?> deleteAnswer(
            @AccountID UUID accountId,
            @PathVariable Long answerId
    ) {
         deleteAnswerUseCase.execute(accountId, answerId);

        return ResponseDto.ok(null);
    }
}
