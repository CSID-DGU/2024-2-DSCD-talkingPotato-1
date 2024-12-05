package org.dongguk.dscd.wooahan.api.question.repository.mysql.custom;

import com.querydsl.core.types.Projections;
import com.querydsl.core.types.dsl.BooleanExpression;
import com.querydsl.core.types.dsl.Expressions;
import com.querydsl.core.types.dsl.NumberTemplate;
import com.querydsl.jpa.impl.JPAQueryFactory;
import lombok.RequiredArgsConstructor;
import org.dongguk.dscd.wooahan.api.question.domain.mysql.QAnswer;
import org.dongguk.dscd.wooahan.api.question.domain.mysql.QQuestion;
import org.dongguk.dscd.wooahan.api.question.dto.projection.ReadQuestionListProjection;
import org.dongguk.dscd.wooahan.api.question.dto.projection.ReadUserQuestionListProjection;
import org.dongguk.dscd.wooahan.api.user.domain.mysql.QUser;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

@Repository
@RequiredArgsConstructor
public class QuestionRepositoryCustomImpl implements QuestionRepositoryCustom {

    private static final String FULL_TEXT_SEARCH_FUNCTION = "function('question_full_text_search', {0}, {1})";
    private static final Double FULL_TEXT_SEARCH_THRESHOLD = 0.0;

    private final JPAQueryFactory queryFactory;

    @Override
    public List<ReadQuestionListProjection> findQuestionList(String keyword, Pageable pageable) {
        QQuestion question = QQuestion.question;
        QAnswer answer = QAnswer.answer;
        QUser user = QUser.user;

        // 1. 페이징 적용 질문 ID 목록 조회
        List<Long> questionIdList = queryFactory
                .select(question.id)
                .from(question)
                .where(eqKeywordByFullTextSearch(keyword))
                .orderBy(question.createdAt.desc())
                .offset(pageable.getOffset())
                .limit(pageable.getPageSize())
                .fetch();

        // 2. 질문 목록 조회
        return queryFactory.select(
                        Projections.constructor(
                                ReadQuestionListProjection.class,
                                question.id.as("id"),
                                question.content.substring(0, 50).as("preview"),
                                Expressions.cases()
                                        .when(answer.id.count().lt(1L)).then("NONE")
                                        .when(
                                                Expressions.numberTemplate(
                                                    Long.class,
                                                    "SUM(CASE WHEN {0} IS NULL THEN 1 ELSE 0 END)", answer.creator
                                                ).eq(answer.id.count())
                                        ).then("AI")
                                        .otherwise("EXPERT")
                                        .as("answerStatus"),
                                question.createdAt,
                                Expressions.as(
                                        Expressions.cases()
                                                .when(answer.id.countDistinct().isNull()).then(0L)
                                                .otherwise(answer.id.countDistinct()),
                                        "answerCount"
                                ),
                                question.creator.nickname,
                                question.creator.id
                        )
                )
                .from(question)
                .leftJoin(question.creator, user)
                .leftJoin(question.answers, answer)
                .where(question.id.in(questionIdList))
                .groupBy(question.id)
                .orderBy(question.createdAt.desc())
                .fetch();
    }

    @Override
    public List<ReadUserQuestionListProjection> findUserQuestionList(UUID accountId) {
        QQuestion question = QQuestion.question;
        QAnswer answer = QAnswer.answer;
        QUser user = QUser.user;

        List<Long> questionIdList = queryFactory
                .select(question.id)
                .from(question)
                .where(question.creator.id.eq(accountId))
                .orderBy(question.createdAt.desc())
                .limit(3L)
                .fetch();

        return queryFactory.select(
                        Projections.constructor(
                                ReadUserQuestionListProjection.class,
                                question.id.as("id"),
                                question.content.substring(0, 50).as("preview"),
                                Expressions.cases()
                                        .when(answer.id.count().lt(1L)).then("NONE")
                                        .when(
                                                Expressions.numberTemplate(
                                                        Long.class,
                                                        "SUM(CASE WHEN {0} IS NULL THEN 1 ELSE 0 END)", answer.creator
                                                ).eq(answer.id.count())
                                        ).then("AI")
                                        .otherwise("EXPERT")
                                        .as("answerStatus"),
                                question.createdAt,
                                Expressions.as(
                                        Expressions.cases()
                                                .when(answer.id.countDistinct().isNull()).then(0L)
                                                .otherwise(answer.id.countDistinct()),
                                        "answerCount"
                                ),
                                question.creator.nickname,
                                question.creator.id
                        )
                )
                .from(question)
                .leftJoin(question.creator, user)
                .leftJoin(question.answers, answer)
                .where(question.id.in(questionIdList))
                .groupBy(question.id)
                .orderBy(question.createdAt.desc())
                .fetch();
    }

    private BooleanExpression eqKeywordByFullTextSearch(String searchTerm) {
        if (searchTerm == null) {
            return null;
        }

        NumberTemplate<Double> numberTemplate = Expressions.numberTemplate(
                Double.class,
                FULL_TEXT_SEARCH_FUNCTION,
                QQuestion.question.content,
                searchTerm
        );

        return numberTemplate.gt(FULL_TEXT_SEARCH_THRESHOLD);
    }
}
