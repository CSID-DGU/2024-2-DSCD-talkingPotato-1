package org.dongguk.dscd.wooahan.api.user.repository.mysql;

import org.dongguk.dscd.wooahan.api.user.domain.mysql.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.time.LocalTime;
import java.util.List;
import java.util.UUID;

@Repository
public interface UserRepository extends JpaRepository<User, UUID> {

    List<User> findAllByBreakfastTimeAndIsAllowedNotificationAndDeviceTokenIsNotNull(
            LocalTime nowTime,
            Boolean isAllowedServiceNotification
    );

    List<User> findAllByLunchTimeAndIsAllowedNotificationAndDeviceTokenIsNotNull(
            LocalTime nowTime,
            Boolean isAllowedServiceNotification
    );

    List<User> findAllByDinnerTimeAndIsAllowedNotificationAndDeviceTokenIsNotNull(
            LocalTime nowTime,
            Boolean isAllowedServiceNotification
    );

}
