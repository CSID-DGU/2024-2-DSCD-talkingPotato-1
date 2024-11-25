package org.dongguk.dscd.wooahan.api.article.usecase;

import java.util.UUID;

public interface DeleteArticleUseCase {
    /**
     * 칼럼 삭제
     * @param accountId 계정 ID
     * @param articleId 칼럼 ID
     */
    void execute(
            UUID accountId,
            Long articleId
    );
}
