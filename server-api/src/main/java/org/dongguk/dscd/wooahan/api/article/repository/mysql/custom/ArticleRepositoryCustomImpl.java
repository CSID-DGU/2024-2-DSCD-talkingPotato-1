package org.dongguk.dscd.wooahan.api.article.repository.mysql.custom;

import com.querydsl.core.types.dsl.BooleanExpression;
import com.querydsl.core.types.dsl.Expressions;
import com.querydsl.core.types.dsl.NumberTemplate;
import com.querydsl.jpa.impl.JPAQueryFactory;
import lombok.RequiredArgsConstructor;
import org.dongguk.dscd.wooahan.api.article.domain.mysql.Article;
import org.dongguk.dscd.wooahan.api.article.domain.mysql.QArticle;
import org.dongguk.dscd.wooahan.api.article.domain.mysql.QComment;
import org.dongguk.dscd.wooahan.api.expert.domain.mysql.QExpert;
import org.dongguk.dscd.wooahan.api.tag.domain.mysql.QArticleTag;
import org.dongguk.dscd.wooahan.api.tag.domain.mysql.QTag;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Repository;

import java.util.Collections;
import java.util.List;

@Repository
@RequiredArgsConstructor
public class ArticleRepositoryCustomImpl implements ArticleRepositoryCustom {

    private static final String FULL_TEXT_SEARCH_FUNCTION = "function('article_full_text_search', {0}, {1}, {2})";
    private static final Double FULL_TEXT_SEARCH_THRESHOLD = 0.0;

    private final JPAQueryFactory queryFactory;

    @Override
    public List<Article> findArticleList(String keyword, Pageable pageable) {

        QArticle article = QArticle.article;
        QExpert expert = QExpert.expert;
        QComment comment = QComment.comment;
        QArticleTag articleTag = QArticleTag.articleTag;
        QTag tag = QTag.tag;

         return queryFactory.select(article)
                .from(article)
                .join(article.creator, expert).fetchJoin()
                .leftJoin(comment).on(comment.article.eq(article)).fetchJoin()
                .leftJoin(articleTag).on(articleTag.article.eq(article)).fetchJoin()
                .leftJoin(articleTag.tag, tag)
                .where(
                        eqKeywordByFullTextSearch(keyword)
                )
                .groupBy(article.id, article.title, article.content, article.createdAt, expert.nickname, expert.id)
                .orderBy(article.createdAt.desc())
                .offset(pageable.getOffset())
                .limit(pageable.getPageSize())
                .fetch();
    }

    private BooleanExpression eqKeywordByFullTextSearch(String searchTerm) {
        if (searchTerm == null) {
            return null;
        }

        NumberTemplate<Double> numberTemplate = Expressions.numberTemplate(
                Double.class,
                FULL_TEXT_SEARCH_FUNCTION,
                QArticle.article.title,
                QArticle.article.content,
                searchTerm
        );

        return numberTemplate.gt(FULL_TEXT_SEARCH_THRESHOLD);
    }
}
