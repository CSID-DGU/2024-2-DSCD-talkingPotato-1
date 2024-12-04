package org.dongguk.dscd.wooahan.api.article.repository.mysql;

import org.dongguk.dscd.wooahan.api.article.domain.mysql.Article;
import org.dongguk.dscd.wooahan.api.article.dto.projection.ReadArticleListProjection;
import org.dongguk.dscd.wooahan.api.article.dto.projection.ReadArticleProjection;
import org.dongguk.dscd.wooahan.api.article.repository.mysql.custom.ArticleRepositoryCustom;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.Optional;

public interface ArticleRepository extends JpaRepository<Article, Long>, ArticleRepositoryCustom {

    @Query("""
            SELECT
                a.id as id, a.title as title, a.content as content, a.createdAt as createdAt,
                e.nickname as nickname, e.id as creatorId,
                (SELECT COUNT(c) FROM Comment c WHERE c.article = a) as commentCnt,
                (SELECT GROUP_CONCAT(t.name) FROM ArticleTag at JOIN at.tag t WHERE at.article.id = a.id) as tags
            FROM Article a
            JOIN a.creator e
            ORDER BY a.createdAt DESC""")
    Page<ReadArticleListProjection> findAllWithDetail(Pageable pageable);

    @Query("""
            
            SELECT
                a.id as id, a.title as title, a.content as content, a.createdAt as createdAt,
                e.nickname as nickname, e.id as creatorId,
                (SELECT COUNT(c) FROM Comment c WHERE c.article = a) as commentCnt,
                (SELECT GROUP_CONCAT(t.name) FROM ArticleTag at JOIN at.tag t WHERE at.article.id = a.id) as tags
            FROM Article a
            join a.creator e
            WHERE a.id = :articleId""")
    Optional<ReadArticleProjection> findByIdWithDetail(Long articleId);

}
