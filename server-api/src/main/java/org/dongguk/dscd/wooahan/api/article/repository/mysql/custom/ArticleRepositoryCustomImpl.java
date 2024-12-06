package org.dongguk.dscd.wooahan.api.article.repository.mysql.custom;

import com.querydsl.core.types.Projections;
import com.querydsl.core.types.dsl.BooleanExpression;
import com.querydsl.core.types.dsl.Expressions;
import com.querydsl.core.types.dsl.NumberTemplate;
import com.querydsl.jpa.JPAExpressions;
import com.querydsl.jpa.impl.JPAQueryFactory;
import lombok.RequiredArgsConstructor;
import org.dongguk.dscd.wooahan.api.article.domain.mysql.QArticle;
import org.dongguk.dscd.wooahan.api.article.domain.mysql.QComment;
import org.dongguk.dscd.wooahan.api.article.dto.projection.ReadArticleListProjection;
import org.dongguk.dscd.wooahan.api.expert.domain.mysql.QExpert;
import org.dongguk.dscd.wooahan.api.tag.domain.mysql.QArticleTag;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@RequiredArgsConstructor
public class ArticleRepositoryCustomImpl implements ArticleRepositoryCustom {

    private static final String FULL_TEXT_SEARCH_FUNCTION = "function('article_full_text_search', {0}, {1}, {2})";
    private static final Double FULL_TEXT_SEARCH_THRESHOLD = 0.0;

    private final JPAQueryFactory queryFactory;

    @Override
    public List<ReadArticleListProjection> findArticleList(String keyword, Pageable pageable) {
        QArticle article = QArticle.article;
        QExpert expert = QExpert.expert;
        QComment comment = QComment.comment;
        QArticleTag articleTag = QArticleTag.articleTag;

        // 1. 페이징 적용 칼럼 ID 목록 조회
        List<Long> articleList = queryFactory
                .select(article.id)
                .from(article)
                .where(eqKeywordByFullTextSearch(keyword))
                .orderBy(article.createdAt.desc())
                .offset(pageable.getOffset())
                .limit(pageable.getPageSize())
                .fetch();

        // 2. 칼럼 목록 조회
        return queryFactory.select(
                        Projections.constructor(
                                ReadArticleListProjection.class,
                                article.id,
                                article.title,
                                article.content,
                                article.createdAt,
                                article.creator.nickname,
                                article.creator.id,
                                JPAExpressions.select(comment.id.count())
                                        .from(comment)
                                        .where(comment.article.eq(article)),
                                JPAExpressions.select(
                                                Expressions.stringTemplate(
                                                        "GROUP_CONCAT({0})", articleTag.tag.name
                                                )
                                        )
                                        .from(articleTag)
                                        .where(articleTag.article.eq(article))
                        )
                )
                .from(article)
                .join(article.creator, expert)
                .where(article.id.in(articleList))
                .orderBy(article.createdAt.desc())
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
