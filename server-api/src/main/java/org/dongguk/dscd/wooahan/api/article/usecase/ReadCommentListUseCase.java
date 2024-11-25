package org.dongguk.dscd.wooahan.api.article.usecase;

import org.dongguk.dscd.wooahan.api.article.dto.response.ReadCommentListDto;

public interface ReadCommentListUseCase {
    /**
     * 댓글 목록 조회
     * @param articleId 칼럼 ID
     */
    ReadCommentListDto execute(Long articleId);
}
