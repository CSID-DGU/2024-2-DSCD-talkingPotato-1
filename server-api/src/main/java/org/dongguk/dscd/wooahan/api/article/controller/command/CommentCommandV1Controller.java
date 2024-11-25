package org.dongguk.dscd.wooahan.api.article.controller.command;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.dongguk.dscd.wooahan.api.article.dto.request.CreateCommentDto;
import org.dongguk.dscd.wooahan.api.article.usecase.CreateCommentUseCase;
import org.dongguk.dscd.wooahan.api.article.usecase.DeleteCommentUseCase;
import org.dongguk.dscd.wooahan.api.core.annotation.common.AccountID;
import org.dongguk.dscd.wooahan.api.core.dto.ResponseDto;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;

@RestController
@RequiredArgsConstructor
@RequestMapping("/v1")
public class CommentCommandV1Controller {

    private final CreateCommentUseCase createCommentUseCase;

    private final DeleteCommentUseCase deleteCommentUseCase;

    /**
     * 8-2. 댓글 생성
     *
     * @param accountId 계정 ID
     * @param articleId 칼럼 ID
     * @return 응답 DTO
     */
    @PreAuthorize("hasRole('USER')")
    @PostMapping("/articles/{articleId}/comments")
    public ResponseDto<?> createComment(
            @AccountID UUID accountId,
            @PathVariable Long articleId,
            @RequestBody @Valid CreateCommentDto requestDto
    ) {
        createCommentUseCase.execute(accountId, articleId, requestDto);

        return ResponseDto.ok(null);
    }

    /**
     * 8-3. 댓글 삭제
     *
     * @param accountId 계정 ID
     * @param commentId 댓글 ID
     */
    @PreAuthorize("hasRole('USER')")
    @DeleteMapping("/comments/{commentId}")
    public ResponseDto<?> deleteComment(
            @AccountID UUID accountId,
            @PathVariable Long commentId
    ) {
         deleteCommentUseCase.execute(accountId, commentId);

        return ResponseDto.ok(null);
    }

}
