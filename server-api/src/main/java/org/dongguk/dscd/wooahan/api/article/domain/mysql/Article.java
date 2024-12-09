package org.dongguk.dscd.wooahan.api.article.domain.mysql;


import jakarta.persistence.*;
import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.dongguk.dscd.wooahan.api.expert.domain.mysql.Expert;
import org.dongguk.dscd.wooahan.api.tag.domain.mysql.ArticleTag;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Table(name = "articles")
public class Article {
    /* -------------------------------------------- */
    /* Default Column ----------------------------- */
    /* -------------------------------------------- */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    /* -------------------------------------------- */
    /* Information Column - Input ----------------- */
    /* -------------------------------------------- */
    @Column(name = "title", length = 100, nullable = false)
    private String title;

    @Column(name = "content", columnDefinition = "LONGTEXT", nullable = false)
    private String content;

    @Column(name = "created_at", nullable = false)
    private LocalDateTime createdAt;

    /* -------------------------------------------- */
    /* Relation Column - Child -------------------- */
    /* -------------------------------------------- */
    @OneToMany(mappedBy = "article", cascade = CascadeType.ALL)
    private List<Comment> comments = new ArrayList<>();

    @OneToMany(mappedBy = "article", cascade = CascadeType.ALL)
    private List<ArticleTag> articleTags = new ArrayList<>();

    /* -------------------------------------------- */
    /* Relation Column - Parent ------------------- */
    /* -------------------------------------------- */
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "creator", nullable = false)
    private Expert creator;

    /* -------------------------------------------- */
    /* Functions ---------------------------------- */
    /* -------------------------------------------- */
    @Builder
    public Article(
            String title,
            String content,
            Expert creator
    ) {
        this.title = title;
        this.content = content;

        this.createdAt = LocalDateTime.now();

        this.creator = creator;
    }

    public void updateTitle(String title) { this.title = title; }

    public void updateContent(String content) { this.content = content; }

}
