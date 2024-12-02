package org.dongguk.dscd.wooahan.api.article.controller.query;

import lombok.RequiredArgsConstructor;
import org.dongguk.dscd.wooahan.api.article.usecase.ReadArticleListUseCase;
import org.dongguk.dscd.wooahan.api.article.usecase.ReadArticleUseCase;
import org.dongguk.dscd.wooahan.api.core.dto.ResponseDto;
import org.springframework.data.domain.Pageable;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("/v1/articles")
public class ArticleQueryV1Controller {

    private final ReadArticleListUseCase readArticleListUseCase;
    private final ReadArticleUseCase readArticleUseCase;

    /**
     * 7-1. 칼럼 목록 조회
     *
     * @param query 쿼리
     * @return 응답 DTO
     */
    @GetMapping
    public ResponseDto<?> readArticleList(
        @RequestParam(required = false, name = "q") String query,
        Pageable pageable
    ) {
        return ResponseDto.ok(readArticleListUseCase.execute(query, pageable));
    }

    /**
     * 7-2. 칼럼 단일 조회
     *
     * @param articleId 칼럼 ID
     * @return 응답 DTO
     */
    @GetMapping("/{articleId}")
    public ResponseDto<?> readArticle(@PathVariable Long articleId) {
        return ResponseDto.ok(readArticleUseCase.execute(articleId));
    }
}
