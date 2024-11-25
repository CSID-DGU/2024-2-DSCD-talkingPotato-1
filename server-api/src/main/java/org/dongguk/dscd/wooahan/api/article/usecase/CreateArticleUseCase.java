package org.dongguk.dscd.wooahan.api.article.usecase;

import org.dongguk.dscd.wooahan.api.article.dto.request.CreateArticleDto;

import java.util.UUID;

public interface CreateArticleUseCase {
    /**
     * 칼럼 생성
     * @param accountId 계정 ID
     * @param requestDto 칼럼 생성 DTO
     */
    void execute(
            UUID accountId,
            CreateArticleDto requestDto
    );
}
