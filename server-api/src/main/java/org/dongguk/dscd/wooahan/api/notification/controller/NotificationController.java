package org.dongguk.dscd.wooahan.api.notification.controller;

import lombok.RequiredArgsConstructor;
import org.dongguk.dscd.wooahan.api.core.dto.ResponseDto;
import org.dongguk.dscd.wooahan.api.notification.service.NotificationService;
import org.dongguk.dscd.wooahan.api.user.domain.type.ETime;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.UUID;

// 시연용 controller TODO: 시연 후 삭제 예정

@RestController
@RequiredArgsConstructor
public class NotificationController {

    private final NotificationService notificationService;

    @PostMapping("/v1/users/{userId}/notifications")
    public ResponseDto<?> sendNotification(
            @PathVariable UUID userId,
            @RequestParam ETime time
    ) {
       notificationService.sendPushNotification(userId, time);

       return ResponseDto.ok(null);
    }


}
