package org.dongguk.dscd.wooahan.api.article.repository.mysql;

import org.dongguk.dscd.wooahan.api.article.domain.mysql.Comment;
import org.dongguk.dscd.wooahan.api.article.dto.projection.ReadCommentListProjection;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface CommentRepository extends JpaRepository<Comment, Long> {

    @Query("""
            SELECT
                c.id as id, c.content as content, c.createdAt as createdAt,
                e.nickname as nickname, e.id as creatorId
            FROM Comment c
            JOIN c.creator e
            WHERE c.article.id = :articleId""")
    List<ReadCommentListProjection> findAllWithDetailByArticleId(Long articleId);
}
