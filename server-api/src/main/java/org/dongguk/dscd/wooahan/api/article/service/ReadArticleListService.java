package org.dongguk.dscd.wooahan.api.article.service;

import lombok.RequiredArgsConstructor;
import org.dongguk.dscd.wooahan.api.article.domain.mysql.Article;
import org.dongguk.dscd.wooahan.api.article.dto.response.ReadArticleListDto;
import org.dongguk.dscd.wooahan.api.article.repository.mysql.ArticleRepository;
import org.dongguk.dscd.wooahan.api.article.usecase.ReadArticleListUseCase;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
public class ReadArticleListService implements ReadArticleListUseCase {

    private final ArticleRepository articleRepository;

    @Override
    @Transactional(readOnly = true)
    public ReadArticleListDto execute(
            String query,
            Pageable pageable
    ) {
        List<Article> articles = articleRepository.findArticleList(query, pageable);

        return ReadArticleListDto.builder()
                .articles(articles.stream()
                        .map(article -> ReadArticleListDto.ReadArticleDto.builder()
                                .id(article.getId())
                                .title(article.getTitle())
                                .preview(article.getContent().substring(Math.min(article.getContent().length(), 50)))
                                .tags(article.getArticleTags().stream().map(articleTag -> articleTag.getTag().getName()).toList())
                                .createdAt(article.getCreatedAt())
                                .commentCnt(article.getComments().size())
                                .nickname(article.getCreator().getNickname())
                                .creatorId(article.getCreator().getId())
                                .build())
                        .toList())
                .build();
    }
}
