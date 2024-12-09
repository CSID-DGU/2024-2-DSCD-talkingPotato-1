package org.dongguk.dscd.wooahan.api.core.scheduler;

import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.scheduling.concurrent.ThreadPoolTaskScheduler;
import org.springframework.stereotype.Component;

import java.time.Instant;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ScheduledFuture;

@Component
@RequiredArgsConstructor
public class UpdaterScheduler implements InitializingBean {

    private final ThreadPoolTaskScheduler threadPoolTaskScheduler;

    private static Map<Long, ScheduledFuture<?>> tasks;

    @Override
    public void afterPropertiesSet() throws Exception {
        tasks = new ConcurrentHashMap<>();
    }

    public void addQuestionTask(Long questionId, Runnable task, Instant instant) {
        ScheduledFuture<?> scheduledFuture = threadPoolTaskScheduler.schedule(task, instant);

        tasks.put(questionId, scheduledFuture);
    }

    public void removeQuestionTask(Long questionId) {
        ScheduledFuture<?> scheduledFuture = tasks.get(questionId);

        if (scheduledFuture != null) {
            scheduledFuture.cancel(false);
            tasks.remove(questionId);
        }
    }
}
