package org.dongguk.dscd.wooahan.api.article.service;

import lombok.RequiredArgsConstructor;
import org.dongguk.dscd.wooahan.api.article.dto.projection.ReadCommentListProjection;
import org.dongguk.dscd.wooahan.api.article.dto.response.ReadCommentListDto;
import org.dongguk.dscd.wooahan.api.article.repository.mysql.ArticleRepository;
import org.dongguk.dscd.wooahan.api.article.repository.mysql.CommentRepository;
import org.dongguk.dscd.wooahan.api.article.usecase.ReadCommentListUseCase;
import org.dongguk.dscd.wooahan.api.core.exception.error.ErrorCode;
import org.dongguk.dscd.wooahan.api.core.exception.type.CommonException;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class ReadCommentListService implements ReadCommentListUseCase {

    private final CommentRepository commentRepository;

    private final ArticleRepository articleRepository;

    @Override
    public ReadCommentListDto execute(Long articleId) {
        articleRepository.findById(articleId)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_ARTICLE));

        List<ReadCommentListProjection> comments = commentRepository.findAllWithDetailByArticleId(articleId);

        return ReadCommentListDto.builder()
                .comments(comments.stream()
                        .map(comment -> ReadCommentListDto.ReadCommentDto.builder()
                                .id(comment.getId())
                                .content(comment.getContent())
                                .createdAt(comment.getCreatedAt())
                                .nickname(comment.getNickname())
                                .creatorId(comment.getCreatorId())
                                .build())
                        .toList())
                .build();
    }
}
