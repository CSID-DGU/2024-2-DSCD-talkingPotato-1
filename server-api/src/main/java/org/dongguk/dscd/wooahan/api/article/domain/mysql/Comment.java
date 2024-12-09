package org.dongguk.dscd.wooahan.api.article.domain.mysql;

import jakarta.persistence.*;
import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.dongguk.dscd.wooahan.api.user.domain.mysql.User;

import java.time.LocalDateTime;

@Entity
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Table(name = "comments")
public class Comment {
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
    @Column(name = "content", length = 100, nullable = false)
    private String content;

    @Column(name = "created_at", nullable = false)
    private LocalDateTime createdAt;

    /* -------------------------------------------- */
    /* Relation Column - Parent ------------------- */
    /* -------------------------------------------- */
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "creator", nullable = false)
    private User creator;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "article_id", nullable = false)
    private Article article;

    /* -------------------------------------------- */
    /* Functions ---------------------------------- */
    /* -------------------------------------------- */
    @Builder
    public Comment(
            String content,
            User creator,
            Article article
    ) {
        this.content = content;

        this.createdAt = LocalDateTime.now();

        this.creator = creator;
        this.article = article;
    }
}
