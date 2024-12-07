package org.dongguk.dscd.wooahan.api.user.domain.mysql;

import jakarta.persistence.*;
import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.dongguk.dscd.wooahan.api.article.domain.mysql.Comment;
import org.dongguk.dscd.wooahan.api.medication.domain.mysql.Medication;
import org.dongguk.dscd.wooahan.api.question.domain.mysql.Question;
import org.dongguk.dscd.wooahan.api.security.domain.mysql.Account;
import org.dongguk.dscd.wooahan.api.security.domain.type.EProvider;
import org.dongguk.dscd.wooahan.api.security.domain.type.ERole;
import org.dongguk.dscd.wooahan.api.user.domain.type.EGender;
import org.hibernate.annotations.DynamicUpdate;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Table(name = "users")
@PrimaryKeyJoinColumn(
        name = "account_id",
        foreignKey = @ForeignKey(name = "user_account_fk")
)
@DiscriminatorValue("USER")
@DynamicUpdate
public class User extends Account {

    /* -------------------------------------------- */
    /* Information Column - Pass ------------------ */
    /* -------------------------------------------- */
    @Column(name = "name", length = 32, nullable = true, updatable = false)
    private String name;

    @Enumerated(EnumType.STRING)
    @Column(name = "gender", nullable = true, updatable = false)
    private EGender gender;

    @Column(name = "date_of_birth", nullable = true, updatable = false)
    private LocalDate dateOfBirth;

    @Column(name = "cell_phone_number", length = 11, nullable = true)
    private String cellPhoneNumber;

    /* -------------------------------------------- */
    /* Information Column - Input ----------------- */
    /* -------------------------------------------- */
    @Column(name = "nickname", length = 10, nullable = false)
    private String nickname;

    @Column(name = "is_allowed_notification", nullable = false)
    private Boolean isAllowedNotification;

    @Column(name = "breakfast_time", nullable = false)
    private LocalTime breakfastTime;

    @Column(name = "lunch_time", nullable = false)
    private LocalTime lunchTime;

    @Column(name = "dinner_time", nullable = false)
    private LocalTime dinnerTime;

    @Column(name = "device_token", length = 320, nullable = true)
    private String deviceToken;

    /* -------------------------------------------- */
    /* Relation Column - Child -------------------- */
    /* -------------------------------------------- */
    @OneToMany(mappedBy = "creator", cascade = CascadeType.ALL)
    private List<Medication> medications = new ArrayList<>();

    @OneToMany(mappedBy = "creator", cascade = CascadeType.ALL)
    private List<Question> questions = new ArrayList<>();

    @OneToMany(mappedBy = "creator", cascade = CascadeType.ALL)
    private List<Comment> comments = new ArrayList<>();


    /* -------------------------------------------- */
    /* Relation Column - Parent ------------------- */
    /* -------------------------------------------- */


    /* -------------------------------------------- */
    /* Functions ---------------------------------- */
    /* -------------------------------------------- */
    @Builder
    public User(
            String serialEmail,
            String password,
            EProvider provider,
            String nickname
    ) {
        super(
                serialEmail,
                password,
                provider
        );

        this.name = null;
        this.dateOfBirth = null;
        this.gender = null;
        this.cellPhoneNumber = null;

        this.nickname = nickname;

        this.isAllowedNotification = Boolean.TRUE;

        this.breakfastTime = LocalTime.of(7, 0);
        this.lunchTime = LocalTime.of(11, 0);
        this.dinnerTime = LocalTime.of(17, 0);

        this.deviceToken = null;
    }

    @Override
    public ERole getRole() {
        return ERole.USER;
    }

    @Override
    public void logout() {
        this.deviceToken = null;
    }

    public void updateNickname(String nickname) {
        this.nickname = nickname;
    }

    public void updateIsAllowedNotification(Boolean isAllowedNotification) {
        this.isAllowedNotification = isAllowedNotification;
    }

    public void updateBreakfastTime(LocalTime breakfastTime) {
        this.breakfastTime = breakfastTime;
    }

    public void updateLunchTime(LocalTime lunchTime) {
        this.lunchTime = lunchTime;
    }

    public void updateDinnerTime(LocalTime dinnerTime) {
        this.dinnerTime = dinnerTime;
    }

    public void updateDeviceToken(String deviceToken) {
        this.deviceToken = deviceToken;
    }
}
