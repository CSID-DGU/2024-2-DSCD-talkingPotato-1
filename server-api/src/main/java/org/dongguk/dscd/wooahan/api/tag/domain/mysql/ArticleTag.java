package org.dongguk.dscd.wooahan.api.tag.domain.mysql;

import jakarta.persistence.*;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.dongguk.dscd.wooahan.api.article.domain.mysql.Article;

@Entity
@Getter
@NoArgsConstructor(access = lombok.AccessLevel.PROTECTED)
@Table(name = "article_tags")
public class ArticleTag {
    /* -------------------------------------------- */
    /* Default Column ----------------------------- */
    /* -------------------------------------------- */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    /* -------------------------------------------- */
    /* Relation Column - Parent ------------------- */
    /* -------------------------------------------- */
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "article_id", nullable = false)
    private Article article;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "tag_id", nullable = false)
    private Tag tag;

    /* -------------------------------------------- */
    /* Functions ---------------------------------- */
    /* -------------------------------------------- */
    @Builder
    public ArticleTag(
            Article article,
            Tag tag
    ) {
        this.article = article;
        this.tag = tag;
    }
}
