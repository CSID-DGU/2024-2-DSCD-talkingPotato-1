package org.dongguk.dscd.wooahan.api.article.service;

import lombok.RequiredArgsConstructor;
import org.dongguk.dscd.wooahan.api.article.dto.projection.ReadArticleListProjection;
import org.dongguk.dscd.wooahan.api.article.dto.response.ReadArticleListDto;
import org.dongguk.dscd.wooahan.api.article.repository.mysql.ArticleRepository;
import org.dongguk.dscd.wooahan.api.article.usecase.ReadArticleListUseCase;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.Collections;
import java.util.List;

@Service
@RequiredArgsConstructor
public class ReadArticleListService implements ReadArticleListUseCase {

    private final ArticleRepository articleRepository;

    @Override
    public ReadArticleListDto execute(
            String query,
            Pageable pageable
    ) {
        List<ReadArticleListProjection> articles = articleRepository.findArticleList(query, pageable);

        return ReadArticleListDto.builder()
                .articles(articles.stream()
                        .map(article -> ReadArticleListDto.ReadArticleDto.builder()
                                .id(article.id())
                                .title(article.title())
                                .preview(article.preview())
                                .tags(getTagNames(article.tags()))
                                .createdAt(article.createdAt())
                                .commentCnt(article.commentCnt())
                                .nickname(article.nickname())
                                .creatorId(article.creatorId())
                                .build())
                        .toList())
                .build();
    }

    private List<String> getTagNames(String tags) {
        if (tags == null) {
            return Collections.emptyList();
        }
        return List.of(tags.split(","));
    }
}
