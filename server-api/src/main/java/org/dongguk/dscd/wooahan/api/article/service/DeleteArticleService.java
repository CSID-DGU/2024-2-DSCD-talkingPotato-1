package org.dongguk.dscd.wooahan.api.article.service;

import lombok.RequiredArgsConstructor;
import org.dongguk.dscd.wooahan.api.article.domain.mysql.Article;
import org.dongguk.dscd.wooahan.api.article.repository.mysql.ArticleRepository;
import org.dongguk.dscd.wooahan.api.article.usecase.DeleteArticleUseCase;
import org.dongguk.dscd.wooahan.api.core.exception.error.ErrorCode;
import org.dongguk.dscd.wooahan.api.core.exception.type.CommonException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.UUID;

@Service
@RequiredArgsConstructor
public class DeleteArticleService implements DeleteArticleUseCase {

    private final ArticleRepository articleRepository;

    @Override
    @Transactional
    public void execute(
            UUID accountId,
            Long articleId
    ) {
        Article article = articleRepository.findById(articleId)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_ARTICLE));

        if (!article.getCreator().getId().equals(accountId)) {
            throw new CommonException(ErrorCode.ACCESS_DENIED_ARTICLE); // 삭제 권한 없음
        }

        articleRepository.delete(article);

    }
}
