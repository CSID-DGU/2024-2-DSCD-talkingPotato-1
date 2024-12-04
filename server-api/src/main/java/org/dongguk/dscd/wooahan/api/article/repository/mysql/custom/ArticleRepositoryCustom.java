package org.dongguk.dscd.wooahan.api.article.repository.mysql.custom;

import org.dongguk.dscd.wooahan.api.article.dto.projection.ReadArticleListProjection;
import org.springframework.data.domain.Pageable;

import java.util.List;

public interface ArticleRepositoryCustom {
    List<ReadArticleListProjection> findArticleList(String keyword, Pageable pageable);
}
