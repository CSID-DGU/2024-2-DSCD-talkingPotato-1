package org.dongguk.dscd.wooahan.api.article.usecase;

import org.dongguk.dscd.wooahan.api.article.dto.response.ReadArticleListDto;
import org.springframework.data.domain.Pageable;

public interface ReadArticleListUseCase {
    /**
     * 칼럼 목록 조회
     * @param query 쿼리
     * @param pageable 페이지 정보
     */
    ReadArticleListDto execute(
            String query,
            Pageable pageable
    );
}
