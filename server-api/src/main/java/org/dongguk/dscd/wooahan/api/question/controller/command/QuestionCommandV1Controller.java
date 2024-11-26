package org.dongguk.dscd.wooahan.api.question.controller.command;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.dongguk.dscd.wooahan.api.core.annotation.common.AccountID;
import org.dongguk.dscd.wooahan.api.core.dto.ResponseDto;
import org.dongguk.dscd.wooahan.api.question.dto.request.CreateQuestionRequestDto;
import org.dongguk.dscd.wooahan.api.question.usecase.CreateQuestionUseCase;
import org.dongguk.dscd.wooahan.api.question.usecase.DeleteQuestionUseCase;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;

@RestController
@RequiredArgsConstructor
@RequestMapping("/v1/questions")
public class QuestionCommandV1Controller {

    private final CreateQuestionUseCase createQuestionUseCase;
    private final DeleteQuestionUseCase deleteQuestionUseCase;

    /**
     * 9-3. 질문 생성
     *
     * @param accountId 계정 ID
     * @param requestDto 질문 생성 DTO
     * @return 응답 DTO
     */
    @PreAuthorize("hasRole('USER')")
    @PostMapping
    public ResponseDto<?> createQuestion(
            @AccountID UUID accountId,
            @RequestBody @Valid CreateQuestionRequestDto requestDto
    ) {
        createQuestionUseCase.execute(accountId, requestDto);

        return ResponseDto.ok(null);
    }

    /**
     * 9-4. 질문 삭제
     *
     * @param accountId 계정 ID
     * @param questionId 질문 ID
     * @return 응답 DTO
     */
    @PreAuthorize("hasRole('USER')")
    @DeleteMapping("/{questionId}")
    public ResponseDto<?> deleteQuestion(
            @AccountID UUID accountId,
            @PathVariable Long questionId
    ) {
         deleteQuestionUseCase.execute(accountId, questionId);

        return ResponseDto.ok(null);
    }
}
