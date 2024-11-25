package org.dongguk.dscd.wooahan.api.article.service;

import lombok.RequiredArgsConstructor;
import org.dongguk.dscd.wooahan.api.article.domain.mysql.Article;
import org.dongguk.dscd.wooahan.api.article.dto.request.CreateArticleDto;
import org.dongguk.dscd.wooahan.api.article.repository.mysql.ArticleRepository;
import org.dongguk.dscd.wooahan.api.article.usecase.CreateArticleUseCase;
import org.dongguk.dscd.wooahan.api.core.exception.error.ErrorCode;
import org.dongguk.dscd.wooahan.api.core.exception.type.CommonException;
import org.dongguk.dscd.wooahan.api.expert.domain.mysql.Expert;
import org.dongguk.dscd.wooahan.api.expert.repository.ExpertRepository;
import org.dongguk.dscd.wooahan.api.tag.domain.mysql.ArticleTag;
import org.dongguk.dscd.wooahan.api.tag.domain.mysql.Tag;
import org.dongguk.dscd.wooahan.api.tag.repository.mysql.ArticleTagRepository;
import org.dongguk.dscd.wooahan.api.tag.repository.mysql.TagRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class CreateArticleService implements CreateArticleUseCase {

    private final ExpertRepository expertRepository;

    private final TagRepository tagRepository;

    private final ArticleRepository articleRepository;

    private final ArticleTagRepository articleTagRepository;

    @Override
    @Transactional
    public void execute(
            UUID accountId,
            CreateArticleDto requestDto
    ) {
        Expert expert = expertRepository.findById(accountId)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        List<Tag> tags = requestDto.tags().stream()
                .map(this::findOrCreateTags)
                .toList();

        Article article = Article.builder()
                .title(requestDto.title())
                .content(requestDto.content())
                .creator(expert)
                .build();

        List<ArticleTag> articleTags = tags.stream()
                .map(tag -> ArticleTag.builder()
                        .article(article)
                        .tag(tag)
                        .build())
                .toList();

        articleRepository.save(article);
        articleTagRepository.saveAll(articleTags);

    }

    private Tag findOrCreateTags(String name) {
        return tagRepository.findByName(name)
                .orElseGet(() -> tagRepository.save(Tag.builder().name(name).build()));
    }
}
