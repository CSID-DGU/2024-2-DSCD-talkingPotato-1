package org.dongguk.dscd.wooahan.api.question.repository.mysql;

import org.dongguk.dscd.wooahan.api.question.domain.mysql.Answer;
import org.dongguk.dscd.wooahan.api.question.dto.projection.ReadAnswerListProjection;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface AnswerRepository extends JpaRepository<Answer, Long> {

    @Query("""
        SELECT a.id AS id, a.content AS content, a.createdAt AS createdAt, e.nickname AS nickname, e.id AS creatorId
        FROM Answer a
        LEFT JOIN a.creator e
        WHERE a.question.id = :questionId
    """)
    List<ReadAnswerListProjection> findAllByQuestionIdWithDetail(Long questionId);
}
