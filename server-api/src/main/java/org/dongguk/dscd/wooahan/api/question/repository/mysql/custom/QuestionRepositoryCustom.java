package org.dongguk.dscd.wooahan.api.question.repository.mysql.custom;

import org.dongguk.dscd.wooahan.api.question.dto.projection.ReadQuestionListProjection;
import org.dongguk.dscd.wooahan.api.question.dto.projection.ReadUserQuestionListProjection;
import org.springframework.data.domain.Pageable;

import java.util.List;
import java.util.UUID;

public interface QuestionRepositoryCustom {
    List<ReadQuestionListProjection> findQuestionList(String keyword, Pageable pageable);

    List<ReadUserQuestionListProjection> findUserQuestionList(UUID accountId);
}
