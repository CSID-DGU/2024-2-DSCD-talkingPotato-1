package org.dongguk.dscd.wooahan.api.notification.service;

import com.google.firebase.messaging.*;
import lombok.RequiredArgsConstructor;
import org.dongguk.dscd.wooahan.api.core.exception.error.ErrorCode;
import org.dongguk.dscd.wooahan.api.core.exception.type.CommonException;
import org.dongguk.dscd.wooahan.api.user.domain.mysql.User;
import org.dongguk.dscd.wooahan.api.user.domain.type.ETime;
import org.dongguk.dscd.wooahan.api.user.repository.mysql.UserRepository;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import java.time.LocalTime;
import java.util.List;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class NotificationService {

    private final UserRepository userRepository;

    private static final String BREAKFAST_NOTIFICATION_CONTENT_FORM = "%s님 아침 약 드실 시간이에요!";
    private static final String LUNCH_NOTIFICATION_CONTENT_FORM = "%s님 점심 약 드실 시간이에요!";
    private static final String DINNER_NOTIFICATION_CONTENT_FORM = "%s님 저녁 약 드실 시간이에요!";

    @Scheduled(cron = "0 0/5 5-9 * * *")
    public void sendPushNotificationOnBreakfast() {
        // 1. 현재 시간 조회
        LocalTime nowTime = LocalTime.now()
                .withMinute((LocalTime.now().getMinute() / 15) * 15)
                .withSecond(0).withNano(0);

        // 2. 현재 시간에 알림을 받아야 하는 사용자 목록 조회
        List<User> recieverList = userRepository.findAllByBreakfastTimeAndIsAllowedNotificationAndDeviceTokenIsNotNull(
                nowTime,
                true
        );

        // 3. 사용자 목록을 통해 알림 메시지 생성
        List<Message> messageList = recieverList.stream()
                .map(user -> convertToMap(user, ETime.BREAKFAST))
                .toList();

        // 4. 알림 메시지 전송
        for (Message message : messageList) {
            try {
                FirebaseMessaging.getInstance().send(message);
            } catch (FirebaseMessagingException ignore) {
            }
        }
    }

    @Scheduled(cron = "0 0/5 10-14 * * *")
    public void sendPushNotificationOnLunch() {
        // 1. 현재 시간 조회
        LocalTime nowTime = LocalTime.now()
                .withMinute((LocalTime.now().getMinute() / 15) * 15)
                .withSecond(0).withNano(0);

        // 2. 현재 시간에 알림을 받아야 하는 사용자 목록 조회
        List<User> recieverList = userRepository.findAllByLunchTimeAndIsAllowedNotificationAndDeviceTokenIsNotNull(
                nowTime,
                true
        );

        // 3. 사용자 목록을 통해 알림 메시지 생성
        List<Message> messageList = recieverList.stream()
                .map(user -> convertToMap(user, ETime.LUNCH))
                .toList();

        // 4. 알림 메시지 전송
        for (Message message : messageList) {
            try {
                FirebaseMessaging.getInstance().send(message);
            } catch (FirebaseMessagingException ignore) {
            }
        }
    }

    @Scheduled(cron = "0 0/5 15-19 * * *")
    public void sendPushNotificationOnDinner() {
        // 1. 현재 시간 조회
        LocalTime nowTime = LocalTime.now()
                .withMinute((LocalTime.now().getMinute() / 15) * 15)
                .withSecond(0).withNano(0);

        // 2. 현재 시간에 알림을 받아야 하는 사용자 목록 조회
        List<User> recieverList = userRepository.findAllByDinnerTimeAndIsAllowedNotificationAndDeviceTokenIsNotNull(
                nowTime,
                true
        );

        // 3. 사용자 목록을 통해 알림 메시지 생성
        List<Message> messageList = recieverList.stream()
                .map(user -> convertToMap(user, ETime.DINNER))
                .toList();

        // 4. 알림 메시지 전송
        for (Message message : messageList) {
            try {
                FirebaseMessaging.getInstance().send(message);
            } catch (FirebaseMessagingException ignore) {
            }
        }
    }

    Message convertToMap(User user, ETime time) {
        String content = switch (time) {
            case BREAKFAST -> String.format(BREAKFAST_NOTIFICATION_CONTENT_FORM, user.getNickname());
            case LUNCH -> String.format(LUNCH_NOTIFICATION_CONTENT_FORM, user.getNickname());
            case DINNER -> String.format(DINNER_NOTIFICATION_CONTENT_FORM, user.getNickname());
        };

        return Message.builder()
                .setToken(user.getDeviceToken())
                .setNotification(
                        Notification.builder()
                                .setTitle("우아한")
                                .setBody(content)
                                .build()
                )
                .setAndroidConfig(
                        AndroidConfig.builder()
                                .setNotification(
                                        AndroidNotification.builder()
                                                .setPriority(AndroidNotification.Priority.HIGH)
                                                .setChannelId("wooahan_remote_channel_id")
                                                .setSound("noti.wav")
                                                .build()
                                )
                                .build()
                )
                .setApnsConfig(
                        ApnsConfig.builder()
                                .setAps(
                                        Aps.builder()
                                                .setSound("noti.wav")
                                                .build()
                                )
                                .setFcmOptions(
                                        ApnsFcmOptions.builder()
                                                .setAnalyticsLabel("wooahan")
                                                .build()
                                )
                                .build()
                )
                .build();
    }

    public void sendPushNotification(
            UUID userId,
            ETime time
    ) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        Message message = convertToMap(user, time);

        try {
            FirebaseMessaging.getInstance().send(message);
        } catch (FirebaseMessagingException ignore) {
        }
    }
}
