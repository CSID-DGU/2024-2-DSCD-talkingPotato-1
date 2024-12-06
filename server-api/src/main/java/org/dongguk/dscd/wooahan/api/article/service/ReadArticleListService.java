package org.dongguk.dscd.wooahan.api.article.service;

import lombok.RequiredArgsConstructor;
import org.commonmark.node.Node;
import org.commonmark.parser.Parser;
import org.commonmark.renderer.html.HtmlRenderer;
import org.dongguk.dscd.wooahan.api.article.dto.projection.ReadArticleListProjection;
import org.dongguk.dscd.wooahan.api.article.dto.response.ReadArticleListDto;
import org.dongguk.dscd.wooahan.api.article.repository.mysql.ArticleRepository;
import org.dongguk.dscd.wooahan.api.article.usecase.ReadArticleListUseCase;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.Collections;
import java.util.List;
import java.util.regex.Pattern;

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
                                .preview(parseTextInPreview(article.preview()))
                                .tags(getTagNames(article.tags()))
                                .createdAt(article.createdAt())
                                .commentCnt(article.commentCnt())
                                .nickname(article.nickname())
                                .creatorId(article.creatorId())
                                .thumbnailUrl(parseThumbnailImageUrl(article.preview()))
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

    private String parseThumbnailImageUrl(String content) {
        String regex = "!\\[.*?\\]\\(.*?\\)";

        List<String> imageList = Pattern.compile(regex)
                .matcher(content)
                .results()
                .map(matchResult -> matchResult.group().split("\\(")[1].split("\\)")[0])
                .toList();

        return imageList.isEmpty() ? null : imageList.get(0);
    }

    private String parseTextInPreview(String content) {

        // 1. Markdown을 DOM Tree로 변환
        Parser parser = Parser.builder().build();
        Node document = parser.parse(content);

        // 2. DOM Tree에서 HTML로 변환
        HtmlRenderer renderer = HtmlRenderer.builder().build();
        String html = renderer.render(document);

        // 3. HTML에서 텍스트 추출
        Document doc = Jsoup.parse(html);
        String parsedText = doc.text();

        // 4. 200자 이상이면 200자까지만 반환
        if (parsedText.length() > 200) {
            return parsedText.substring(0, 200);
        }

        // 5. 200자 미만이면 전체 반환
        return parsedText;
    }
}
