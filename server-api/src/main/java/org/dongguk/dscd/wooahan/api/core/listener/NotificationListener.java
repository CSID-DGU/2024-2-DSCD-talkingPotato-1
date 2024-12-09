package org.dongguk.dscd.wooahan.api.core.listener;

import lombok.RequiredArgsConstructor;
import org.dongguk.dscd.wooahan.api.notification.service.NotificationService;
import org.dongguk.dscd.wooahan.api.question.event.CreateAnswerEvent;
import org.dongguk.dscd.wooahan.api.question.event.CreateQuestionEvent;
import org.springframework.context.event.EventListener;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class NotificationListener {

    private final NotificationService notificationService;

    @Async
    @EventListener(classes = {CreateAnswerEvent.class})
    public void handleCreateAnswerEvent(
            CreateAnswerEvent event
    ) {
        notificationService.sendPushNotification(event.userId());
    }
}
