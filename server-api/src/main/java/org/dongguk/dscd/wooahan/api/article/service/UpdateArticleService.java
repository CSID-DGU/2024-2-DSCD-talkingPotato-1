package org.dongguk.dscd.wooahan.api.article.service;

import lombok.RequiredArgsConstructor;
import org.dongguk.dscd.wooahan.api.article.domain.mysql.Article;
import org.dongguk.dscd.wooahan.api.article.dto.request.UpdateArticleDto;
import org.dongguk.dscd.wooahan.api.article.repository.mysql.ArticleRepository;
import org.dongguk.dscd.wooahan.api.article.usecase.UpdateArticleUseCase;
import org.dongguk.dscd.wooahan.api.core.exception.error.ErrorCode;
import org.dongguk.dscd.wooahan.api.core.exception.type.CommonException;
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
public class UpdateArticleService implements UpdateArticleUseCase {

    private final ArticleRepository articleRepository;

    private final TagRepository tagRepository;

    private final ArticleTagRepository articleTagRepository;

    @Override
    @Transactional
    public void execute(
            UUID accountId,
            Long articleId,
            UpdateArticleDto requestDto
    ) {
        Article article = articleRepository.findById(articleId)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_ARTICLE));

        if (!article.getCreator().getId().equals(accountId)) {
            throw new CommonException(ErrorCode.ACCESS_DENIED_ARTICLE); // 수정 권한 없음
        }

        article.updateTitle(requestDto.title());
        article.updateContent(requestDto.content());
        updateTags(article, requestDto);
    }

    private Tag findOrCreateTags(String name) {
        return tagRepository.findByName(name)
                .orElseGet(() -> tagRepository.save(Tag.builder().name(name).build()));
    }

    private void updateTags(Article article, UpdateArticleDto requestDto) {
        List<ArticleTag> currentArticleTags = article.getArticleTags();
        List<String> currentTagNames = currentArticleTags.stream()
                .map(articleTag -> articleTag.getTag().getName())
                .toList();

        List<String> tagsToAdd = requestDto.tags().stream()
                .filter(tag -> !currentTagNames.contains(tag))
                .toList();

        List<String> tagsToRemove = currentTagNames.stream()
                .filter(tag -> !requestDto.tags().contains(tag))
                .toList();

        if (!tagsToRemove.isEmpty()) {
            articleTagRepository.deleteByArticleAndTagNames(article, tagsToRemove);
        }

        List<ArticleTag> articleTags = tagsToAdd.stream()
                .map(tag -> ArticleTag.builder()
                        .article(article)
                        .tag(findOrCreateTags(tag))
                        .build())
                .toList();

        articleTagRepository.saveAll(articleTags);
    }
}
