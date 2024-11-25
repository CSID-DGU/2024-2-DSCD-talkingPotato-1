package org.dongguk.dscd.wooahan.api.article.usecase;

import java.util.UUID;

public interface DeleteCommentUseCase {
    /**
     * 댓글 삭제
     * @param accountId 계정 ID
     * @param commentId 댓글 ID
     */
    void execute(
            UUID accountId,
            Long commentId
    );
}
