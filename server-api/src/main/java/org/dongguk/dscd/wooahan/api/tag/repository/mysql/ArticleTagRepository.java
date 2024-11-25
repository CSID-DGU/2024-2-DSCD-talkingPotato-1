package org.dongguk.dscd.wooahan.api.tag.repository.mysql;

import org.dongguk.dscd.wooahan.api.article.domain.mysql.Article;
import org.dongguk.dscd.wooahan.api.tag.domain.mysql.ArticleTag;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface ArticleTagRepository extends JpaRepository<ArticleTag, Long> {

    @Modifying
    @Query("DELETE FROM ArticleTag at WHERE at.article = :article AND at.tag.name IN :tagNames")
    void deleteByArticleAndTagNames(Article article, List<String> tagNames);

}
