package org.dongguk.dscd.wooahan.api.article.service;

import lombok.RequiredArgsConstructor;
import org.dongguk.dscd.wooahan.api.article.domain.mysql.Comment;
import org.dongguk.dscd.wooahan.api.article.repository.mysql.CommentRepository;
import org.dongguk.dscd.wooahan.api.article.usecase.DeleteCommentUseCase;
import org.dongguk.dscd.wooahan.api.core.exception.error.ErrorCode;
import org.dongguk.dscd.wooahan.api.core.exception.type.CommonException;
import org.springframework.stereotype.Service;

import java.util.UUID;

@Service
@RequiredArgsConstructor
public class DeleteCommentService implements DeleteCommentUseCase {

    private final CommentRepository commentRepository;

    @Override
    public void execute(
            UUID accountId,
            Long commentId
    ) {
        Comment comment = commentRepository.findById(commentId)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_COMMENT));

        if (!comment.getCreator().getId().equals(accountId)) {
            throw new CommonException(ErrorCode.ACCESS_DENIED_COMMENT);
        }

        commentRepository.delete(comment);
    }
}
