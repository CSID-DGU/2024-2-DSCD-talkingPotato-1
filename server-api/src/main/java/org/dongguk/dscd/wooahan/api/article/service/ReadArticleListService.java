package org.dongguk.dscd.wooahan.api.article.service;

import lombok.RequiredArgsConstructor;
import org.dongguk.dscd.wooahan.api.article.dto.projection.ReadArticleListProjection;
import org.dongguk.dscd.wooahan.api.article.dto.response.ReadArticleListDto;
import org.dongguk.dscd.wooahan.api.article.repository.mysql.ArticleRepository;
import org.dongguk.dscd.wooahan.api.article.usecase.ReadArticleListUseCase;
import org.springframework.data.domain.Page;
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
        // TODO: query를 이용한 검색 기능 구현
        Page<ReadArticleListProjection> articles =  articleRepository.findAllWithDetail(pageable);

        return ReadArticleListDto.builder()
                .articles(articles.stream()
                        .map(article -> ReadArticleListDto.ReadArticleDto.builder()
                                .id(article.getId())
                                .title(article.getTitle())
                                .preview(article.getContent())
                                .tags(getTagNames(article.getTags()))
                                .createdAt(article.getCreatedAt())
                                .commentCnt(article.getCommentCnt())
                                .nickname(article.getNickname())
                                .creatorId(article.getCreatorId())
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
