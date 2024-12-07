package org.dongguk.dscd.wooahan.api.expert.domain.mysql;

import jakarta.persistence.*;
import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.dongguk.dscd.wooahan.api.article.domain.mysql.Article;
import org.dongguk.dscd.wooahan.api.question.domain.mysql.Answer;
import org.dongguk.dscd.wooahan.api.security.domain.mysql.Account;
import org.dongguk.dscd.wooahan.api.security.domain.type.EProvider;
import org.dongguk.dscd.wooahan.api.security.domain.type.ERole;
import org.dongguk.dscd.wooahan.api.user.domain.type.EGender;
import org.hibernate.annotations.DynamicUpdate;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;


@Entity
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Table(name = "experts")
@PrimaryKeyJoinColumn(
        name = "account_id",
        foreignKey = @ForeignKey(name = "expert_account_fk")
)
@DiscriminatorValue("EXPERT")
@DynamicUpdate
public class Expert extends Account {

    /* -------------------------------------------- */
    /* Information Column - Pass ------------------ */
    /* -------------------------------------------- */
    @Column(name = "name", length = 32, nullable = true)
    private String name;

    @Column(name = "date_of_birth", nullable = true)
    private LocalDate dateOfBirth;

    @Enumerated(EnumType.STRING)
    @Column(name = "gender", nullable = true)
    private EGender gender;

    @Column(name = "cell_phone_number", length = 11, nullable = true)
    private String cellPhoneNumber;

    /* -------------------------------------------- */
    /* Information Column - Input ----------------- */
    /* -------------------------------------------- */
    @Column(name = "nickname", length = 10, nullable = false)
    private String nickname;

    @Column(name = "career", length = 1000, nullable = false)
    private String career;

    /* -------------------------------------------- */
    /* Relation Column - Child -------------------- */
    /* -------------------------------------------- */
    @OneToMany(mappedBy = "creator", cascade = CascadeType.ALL)
    private List<Article> articles = new ArrayList<>();

    @OneToMany(mappedBy = "creator", cascade = CascadeType.ALL)
    private List<Answer> answers = new ArrayList<>();


    /* -------------------------------------------- */
    /* Relation Column - Parent ------------------- */
    /* -------------------------------------------- */


    /* -------------------------------------------- */
    /* Functions ---------------------------------- */
    /* -------------------------------------------- */
    @Builder
    public Expert(
            String serialId,
            String password,
            EProvider provider,
            String nickname,
            String career
    ) {
        super(
                serialId,
                password,
                provider
        );

        this.nickname = nickname;
        this.career = career;
    }

    @Override
    public void logout() {
        // Not Implemented
    }

    @Override
    public ERole getRole() {
        return ERole.EXPERT;
    }

    @Override
    public String getNickname() {
        return nickname;
    }
}
