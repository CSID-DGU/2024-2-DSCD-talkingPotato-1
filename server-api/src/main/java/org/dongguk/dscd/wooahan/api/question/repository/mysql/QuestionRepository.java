package org.dongguk.dscd.wooahan.api.question.repository.mysql;

import org.dongguk.dscd.wooahan.api.question.domain.mysql.Question;
import org.dongguk.dscd.wooahan.api.question.dto.projection.ReadQuestionProjection;
import org.dongguk.dscd.wooahan.api.question.repository.mysql.custom.QuestionRepositoryCustom;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.Optional;

public interface QuestionRepository extends JpaRepository<Question, Long>, QuestionRepositoryCustom {

    @Query("""
        SELECT
            q.id as id, q.content as content, q.createdAt as createdAt,
            (SELECT COUNT(a) FROM Answer a WHERE a.question = q) as answerCount,
            u.nickname as nickname, u.id as creatorId
        FROM Question q
        JOIN q.creator u
        WHERE q.id = :id
    """)
    Optional<ReadQuestionProjection> findByIdWithDetail(Long id);
}
