package org.dongguk.dscd.wooahan.api.article.usecase;

import org.dongguk.dscd.wooahan.api.article.dto.request.CreateCommentDto;

import java.util.UUID;

public interface CreateCommentUseCase {
    /**
     * 댓글 생성
     * @param accountId 계정 ID
     * @param articleId 칼럼 ID
     * @param requestDto 댓글 생성 DTO
     */
    void execute(
            UUID accountId,
            Long articleId,
            CreateCommentDto requestDto
    );
}
