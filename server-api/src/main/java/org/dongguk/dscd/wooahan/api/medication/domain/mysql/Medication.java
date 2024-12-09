package org.dongguk.dscd.wooahan.api.medication.domain.mysql;

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
@Table(name = "medications")
public class Medication {
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
    @Column(name = "drug_id", nullable = false)
    private Integer drugId;

    @Column(name = "is_taken_in_breakfast", nullable = false)
    private Boolean isTakenInBreakfast;

    @Column(name = "is_taken_in_lunch", nullable = false)
    private Boolean isTakenInLunch;

    @Column(name = "is_taken_in_dinner", nullable = false)
    private Boolean isTakenInDinner;

    @Column(name = "is_taken_in_daily", nullable = false)
    private Boolean isTakenInDaily;

    @Column(name = "created_at", nullable = false)
    private LocalDateTime createdAt;

    /* -------------------------------------------- */
    /* Relation Column - Parent ------------------- */
    /* -------------------------------------------- */
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "creator", nullable = false)
    private User creator;

    /* -------------------------------------------- */
    /* Relation Column - Child -------------------- */
    /* -------------------------------------------- */
    @OneToMany(mappedBy = "medication", cascade = CascadeType.ALL)
    private List<Schedule> schedules = new ArrayList<>();

    /* -------------------------------------------- */
    /* Functions ---------------------------------- */
    /* -------------------------------------------- */
    @Builder
    public Medication(
            Integer drugId,
            Boolean isTakenInBreakfast,
            Boolean isTakenInLunch,
            Boolean isTakenInDinner,
            Boolean isTakenInDaily,
            User creator
    ) {
        this.drugId = drugId;
        this.isTakenInBreakfast = isTakenInBreakfast;
        this.isTakenInLunch = isTakenInLunch;
        this.isTakenInDinner = isTakenInDinner;
        this.isTakenInDaily = isTakenInDaily;

        this.createdAt = LocalDateTime.now();

        this.creator = creator;
    }

    public void updateIsTakenInBreakfast(Boolean isTakenInBreakfast) {
        this.isTakenInBreakfast = isTakenInBreakfast;
    }

    public void updateIsTakenInLunch(Boolean isTakenInLunch) {
        this.isTakenInLunch = isTakenInLunch;
    }

    public void updateIsTakenInDinner(Boolean isTakenInDinner) {
        this.isTakenInDinner = isTakenInDinner;
    }

    public void updateIsTakenInDaily(Boolean isTakenInDaily) {
        this.isTakenInDaily = isTakenInDaily;
    }

}
