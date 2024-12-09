package org.dongguk.dscd.wooahan.api.question.domain.mysql;

import jakarta.persistence.*;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.dongguk.dscd.wooahan.api.user.domain.mysql.User;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Getter
@NoArgsConstructor(access = lombok.AccessLevel.PROTECTED)
@Table(name = "questions")
public class Question {
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
    @Column(name = "content", length = 500, nullable = false)
    private String content;

    @Column(name = "created_at", nullable = false)
    private LocalDateTime createdAt;

    /* -------------------------------------------- */
    /* Relation Column - Child -------------------- */
    /* -------------------------------------------- */
    @OneToMany(mappedBy = "question", cascade = CascadeType.ALL)
    private List<Answer> answers = new ArrayList<>();

    /* -------------------------------------------- */
    /* Relation Column - Parent ------------------- */
    /* -------------------------------------------- */
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "creator", nullable = false)
    private User creator;

    /* -------------------------------------------- */
    /* Functions ---------------------------------- */
    /* -------------------------------------------- */
    @Builder
    public Question(
            String content,
            User creator
    ) {
        this.content = content;

        this.createdAt = LocalDateTime.now();

        this.creator = creator;
    }
}
