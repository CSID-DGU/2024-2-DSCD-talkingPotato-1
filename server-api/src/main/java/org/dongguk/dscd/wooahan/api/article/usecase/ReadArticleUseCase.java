package org.dongguk.dscd.wooahan.api.article.usecase;

import org.dongguk.dscd.wooahan.api.article.dto.response.ReadArticleDto;

public interface ReadArticleUseCase {
    /**
     * 칼럼 단일 조회
     * @param articleId 칼럼 ID
     */
    ReadArticleDto execute(Long articleId);
}
