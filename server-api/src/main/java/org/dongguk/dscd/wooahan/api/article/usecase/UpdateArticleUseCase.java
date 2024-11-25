package org.dongguk.dscd.wooahan.api.article.usecase;

import org.dongguk.dscd.wooahan.api.article.dto.request.UpdateArticleDto;

import java.util.UUID;

public interface UpdateArticleUseCase {
    /**
     * 칼럼 수정
     * @param accountId 계정 ID
     * @param articleId 칼럼 ID
     * @param updateArticleDto 수정할 칼럼 정보
     */
    void execute(
            UUID accountId,
            Long articleId,
            UpdateArticleDto updateArticleDto
    );
}
