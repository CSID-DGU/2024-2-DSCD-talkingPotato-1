package org.dongguk.dscd.wooahan.api.tag.repository.mysql;

import org.dongguk.dscd.wooahan.api.tag.domain.mysql.Tag;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface TagRepository extends JpaRepository<Tag, Long> {

    Optional<Tag> findByName(String name);

}
