package org.dongguk.dscd.wooahan.api.article.controller.query;

import lombok.RequiredArgsConstructor;
import org.dongguk.dscd.wooahan.api.article.usecase.ReadCommentListUseCase;
import org.dongguk.dscd.wooahan.api.core.dto.ResponseDto;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
@RequestMapping("/v1")
public class CommentQueryV1Controller {

    private final ReadCommentListUseCase readCommentListUseCase;

    /**
     * 8-1. 댓글 목록 조회
     *
     * @param articleId 칼럼 ID
     * @return 응답 DTO
     */
    @GetMapping("/articles/{articleId}/comments")
    public ResponseDto<?> readCommentList(@PathVariable Long articleId) {
        return ResponseDto.ok(readCommentListUseCase.execute(articleId));
    }
}
