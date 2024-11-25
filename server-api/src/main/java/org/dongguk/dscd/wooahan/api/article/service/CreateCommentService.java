package org.dongguk.dscd.wooahan.api.article.service;

import lombok.RequiredArgsConstructor;
import org.dongguk.dscd.wooahan.api.article.domain.mysql.Article;
import org.dongguk.dscd.wooahan.api.article.domain.mysql.Comment;
import org.dongguk.dscd.wooahan.api.article.dto.request.CreateCommentDto;
import org.dongguk.dscd.wooahan.api.article.repository.mysql.ArticleRepository;
import org.dongguk.dscd.wooahan.api.article.repository.mysql.CommentRepository;
import org.dongguk.dscd.wooahan.api.article.usecase.CreateCommentUseCase;
import org.dongguk.dscd.wooahan.api.core.exception.error.ErrorCode;
import org.dongguk.dscd.wooahan.api.core.exception.type.CommonException;
import org.dongguk.dscd.wooahan.api.user.domain.mysql.User;
import org.dongguk.dscd.wooahan.api.user.repository.mysql.UserRepository;
import org.springframework.stereotype.Service;

import java.util.UUID;

@Service
@RequiredArgsConstructor
public class CreateCommentService implements CreateCommentUseCase {

    private final CommentRepository commentRepository;

    private final ArticleRepository articleRepository;

    private final UserRepository userRepository;

    @Override
    public void execute(
            UUID accountId,
            Long articleId,
            CreateCommentDto requestDto
    ) {
        Article article = articleRepository.findById(articleId)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_ARTICLE));

        User user = userRepository.findById(accountId)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        Comment comment = Comment.builder()
                .article(article)
                .creator(user)
                .content(requestDto.content())
                .build();

        commentRepository.save(comment);
    }
}
