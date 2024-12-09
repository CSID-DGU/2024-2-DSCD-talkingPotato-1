package org.dongguk.dscd.wooahan.api.medication.domain.mysql;

import jakarta.persistence.*;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.dongguk.dscd.wooahan.api.medication.domain.type.ETakenTime;

import java.time.LocalDate;

@Entity
@Getter
@NoArgsConstructor(access = lombok.AccessLevel.PROTECTED)
@Table(name = "schedules")
public class Schedule {
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
    @Column(name = "took_at", nullable = false)
    private LocalDate tookAt;

    @Enumerated(EnumType.STRING)
    @Column(name = "taken_time", nullable = false)
    private ETakenTime takenTime;

    /* -------------------------------------------- */
    /* Relation Column - Parent ------------------- */
    /* -------------------------------------------- */
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "medication_id", nullable = false)
    private Medication medication;


    /* -------------------------------------------- */
    /* Functions ---------------------------------- */
    /* -------------------------------------------- */
    @Builder
    public Schedule(
            LocalDate tookAt,
            ETakenTime takenTime,
            Medication medication
    ) {
        this.tookAt = tookAt;
        this.takenTime = takenTime;

        this.medication = medication;
    }

}
