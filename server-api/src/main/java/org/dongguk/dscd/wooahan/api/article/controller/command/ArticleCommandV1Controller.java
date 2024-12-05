package org.dongguk.dscd.wooahan.api.article.controller.command;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.dongguk.dscd.wooahan.api.article.dto.request.CreateArticleDto;
import org.dongguk.dscd.wooahan.api.article.dto.request.UpdateArticleDto;
import org.dongguk.dscd.wooahan.api.article.usecase.CreateArticleUseCase;
import org.dongguk.dscd.wooahan.api.article.usecase.DeleteArticleUseCase;
import org.dongguk.dscd.wooahan.api.article.usecase.UpdateArticleUseCase;
import org.dongguk.dscd.wooahan.api.core.annotation.common.AccountID;
import org.dongguk.dscd.wooahan.api.core.dto.ResponseDto;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;

@RestController
@RequiredArgsConstructor
@RequestMapping("/v1/articles")
public class ArticleCommandV1Controller {

    private final CreateArticleUseCase createArticleUseCase;
    private final UpdateArticleUseCase updateArticleUseCase;
    private final DeleteArticleUseCase deleteArticleUseCase;

    /**
     * 7-3. 칼럼 생성
     *
     * @param accountId  계정 ID
     * @param requestDto 요청 DTO
     * @return 응답 DTO
     */
    @PreAuthorize("hasAnyRole('EXPERT', 'ADMIN')")
    @PostMapping
    public ResponseDto<?> createArticle(
            @AccountID UUID accountId,
            @RequestBody @Valid CreateArticleDto requestDto
    ) {
        createArticleUseCase.execute(accountId, requestDto);

        return ResponseDto.ok(null);
    }

    /**
     * 7-4. 칼럼 수정
     *
     * @param accountId  계정 ID
     * @param articleId  칼럼 ID
     * @param requestDto 요청 DTO
     * @return 응답 DTO
     */
    @PreAuthorize("hasAnyRole('EXPERT', 'ADMIN')")
    @PutMapping("/{articleId}")
    public ResponseDto<?> updateArticle(
            @AccountID UUID accountId,
            @PathVariable Long articleId,
            @RequestBody @Valid UpdateArticleDto requestDto
    ) {
        updateArticleUseCase.execute(accountId, articleId, requestDto);

        return ResponseDto.ok(null);
    }

    /**
     * 7-5. 칼럼 삭제
     *
     * @param accountId 계정 ID
     * @param articleId 칼럼 ID
     * @return 응답 DTO
     */
    @PreAuthorize("hasAnyRole('EXPERT', 'ADMIN')")
    @DeleteMapping("/{articleId}")
    public ResponseDto<?> deleteArticle(
            @AccountID UUID accountId,
            @PathVariable Long articleId
    ) {
         deleteArticleUseCase.execute(accountId, articleId);

        return ResponseDto.ok(null);
    }
}
