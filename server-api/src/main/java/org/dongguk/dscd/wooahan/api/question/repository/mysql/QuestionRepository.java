package org.dongguk.dscd.wooahan.api.question.repository.mysql;

import org.dongguk.dscd.wooahan.api.question.domain.mysql.Question;
import org.dongguk.dscd.wooahan.api.question.dto.projection.ReadQuestionListProjection;
import org.dongguk.dscd.wooahan.api.question.dto.projection.ReadQuestionProjection;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.Optional;

public interface QuestionRepository extends JpaRepository<Question, Long> {

    @Query("""
            SELECT
                q.id as id, q.content as preview, q.createdAt as createdAt,
                CASE
                    WHEN (SELECT COUNT(a) FROM Answer a WHERE a.question = q) = 0 THEN 'NONE'
                    WHEN (SELECT COUNT(a) FROM Answer a WHERE a.question = q AND a.creator IS NOT NULL) = 0 THEN 'AI'
                    ELSE 'EXPERT'
                END as answerStatus,
                (SELECT COUNT(a) FROM Answer a WHERE a.question = q) as answerCount,
                u.nickname as nickname, u.id as creatorId
            FROM Question q
            JOIN q.creator u""")
    Page<ReadQuestionListProjection> findAllWithDetail(Pageable pageable);

    @Query("""
            SELECT
                q.id as id, q.content as content, q.createdAt as createdAt,
                (SELECT COUNT(a) FROM Answer a WHERE a.question = q) as answerCount,
                u.nickname as nickname, u.id as creatorId
            FROM Question q
            JOIN q.creator u""")
    Optional<ReadQuestionProjection> findByIdWithDetail(Long id);
}
