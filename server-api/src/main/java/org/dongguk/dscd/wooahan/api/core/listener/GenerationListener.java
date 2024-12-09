package org.dongguk.dscd.wooahan.api.core.listener;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import org.dongguk.dscd.wooahan.api.question.event.CreateQuestionEvent;
import org.dongguk.dscd.wooahan.api.question.service.CreateAnswerService;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.event.EventListener;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestClient;

import java.util.HashMap;
import java.util.Map;

@Component
@RequiredArgsConstructor
public class GenerationListener {

    @Value("${inner-services.generation.url}")
    String generationServiceUrl;

    private final CreateAnswerService createAnswerService;

    private final ObjectMapper objectMapper;

    private static final RestClient REST_CLIENT = RestClient.create();

    @Async
    @EventListener(classes = {CreateQuestionEvent.class})
    public void handleCreateQuestionEvent(CreateQuestionEvent event) {
        String similarAnswer = "";

        try {
            GenerationResult response = REST_CLIENT.post()
                    .uri(generationServiceUrl + "/v1/generations/similar-questions")
                    .headers(httpHeaders -> {
                        httpHeaders.set("Content-Type", "application/json");
                    })
                    .body(generateMessageJson(event.content()))
                    .retrieve()
                    .body(GenerationResult.class);

            similarAnswer = (String) response.data().get("result");
        } catch (Exception ignored) {
        }

        createAnswerService.execute(
                event.questionId(),
                similarAnswer
        );
    }

    private String generateMessageJson(String content) throws JsonProcessingException {
        Map<String, String> message = new HashMap<>();

        message.put("content", content);

        return objectMapper.writeValueAsString(message);
    }

    private record GenerationResult(
                Boolean success,
                Map<String, Object> data,
                Map<String, Object> error
    ) {
    }
}
