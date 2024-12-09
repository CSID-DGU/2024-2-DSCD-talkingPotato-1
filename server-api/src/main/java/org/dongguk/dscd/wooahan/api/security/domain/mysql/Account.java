package org.dongguk.dscd.wooahan.api.security.domain.mysql;

import jakarta.persistence.*;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.dongguk.dscd.wooahan.api.security.domain.type.EProvider;
import org.dongguk.dscd.wooahan.api.security.domain.type.ERole;
import org.hibernate.annotations.DynamicUpdate;

import java.util.UUID;

@Entity
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Table(name = "accounts", uniqueConstraints = {
        @UniqueConstraint(
                name = "uk_accounts_serial_id",
                columnNames = {"serial_id"}
        )
})
@Inheritance(strategy = InheritanceType.JOINED)
@DiscriminatorColumn(name = "dtype")
@DynamicUpdate
public abstract class Account {

    /* -------------------------------------------- */
    /* Default Column ----------------------------- */
    /* -------------------------------------------- */
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    @Column(name = "id")
    private UUID id;

    /* -------------------------------------------- */
    /* Information Column ------------------------- */
    /* -------------------------------------------- */
    @Enumerated(EnumType.STRING)
    @Column(name = "provider", nullable = false, updatable = false)
    private EProvider provider;

    @Column(name = "serial_id", length = 320, nullable = false, updatable = false)
    private String serialId;

    @Column(name = "password", length = 320, nullable = false)
    private String password;

    /* -------------------------------------------- */
    /* DateTime Column ---------------------------- */
    /* -------------------------------------------- */


    /* -------------------------------------------- */
    /* Relation Column - Child -------------------- */
    /* -------------------------------------------- */


    /* -------------------------------------------- */
    /* Relation Column - Parent ------------------- */
    /* -------------------------------------------- */


    /* -------------------------------------------- */
    /* Functions ---------------------------------- */
    /* -------------------------------------------- */
    public Account(
            String serialId,
            String password,
            EProvider provider
    ) {
        this.serialId = serialId;
        this.password = password;
        this.provider = provider;
    }

    public void updatePassword(String password) {
        this.password = password;
    }

    public abstract void logout();

    public abstract ERole getRole();

    public abstract String getNickname();
}
