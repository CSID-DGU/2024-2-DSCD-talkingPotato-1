package org.dongguk.dscd.wooahan.api.article.service;

import lombok.RequiredArgsConstructor;
import org.dongguk.dscd.wooahan.api.article.dto.projection.ReadArticleProjection;
import org.dongguk.dscd.wooahan.api.article.dto.response.ReadArticleDto;
import org.dongguk.dscd.wooahan.api.article.repository.mysql.ArticleRepository;
import org.dongguk.dscd.wooahan.api.article.usecase.ReadArticleUseCase;
import org.dongguk.dscd.wooahan.api.core.exception.error.ErrorCode;
import org.dongguk.dscd.wooahan.api.core.exception.type.CommonException;
import org.springframework.stereotype.Service;

import java.util.Collections;
import java.util.List;

@Service
@RequiredArgsConstructor
public class ReadArticleService implements ReadArticleUseCase {

    private final ArticleRepository articleRepository;

    @Override
    public ReadArticleDto execute(Long articleId) {
        ReadArticleProjection article = articleRepository.findByIdWithDetail(articleId)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_ARTICLE));

        return ReadArticleDto.builder()
                .id(article.getId())
                .title(article.getTitle())
                .content(article.getContent())
                .createdAt(article.getCreatedAt())
                .nickname(article.getNickname())
                .creatorId(article.getCreatorId())
                .commentCnt(article.getCommentCnt())
                .tags(getTagNames(article.getTags()))
                .build();
    }

    private List<String> getTagNames(String tags) {
        if (tags == null) {
            return Collections.emptyList();
        }
        return List.of(tags.split(","));
    }
}
