package org.dongguk.dscd.wooahan.api.core.listener;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import org.dongguk.dscd.wooahan.api.core.exception.error.ErrorCode;
import org.dongguk.dscd.wooahan.api.core.exception.type.CommonException;
import org.dongguk.dscd.wooahan.api.question.domain.mysql.Answer;
import org.dongguk.dscd.wooahan.api.question.domain.mysql.Question;
import org.dongguk.dscd.wooahan.api.question.event.CreateQuestionEvent;
import org.dongguk.dscd.wooahan.api.question.repository.mysql.AnswerRepository;
import org.dongguk.dscd.wooahan.api.question.repository.mysql.QuestionRepository;
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

    private final QuestionRepository questionRepository;
    private final AnswerRepository answerRepository;

    private final ObjectMapper objectMapper;

    private static final RestClient REST_CLIENT = RestClient.create();

    @Async
    @EventListener(classes = {CreateQuestionEvent.class})
    public void handleCreateQuestionEvent(CreateQuestionEvent event) {
        Question question = questionRepository.findById(event.questionId())
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_RESOURCE));

        String similarAnswer = "";

        try {
            GenerationResult response = REST_CLIENT.post()
                    .uri(generationServiceUrl + "/v1/generations/similar-questions")
                    .headers(httpHeaders -> {
                        httpHeaders.set("Content-Type", "application/json");
                    })
                    .body(generateMessageJson(question.getContent()))
                    .retrieve()
                    .body(GenerationResult.class);

            similarAnswer = (String) response.data().get("result");
        } catch (Exception ignored) {
        }

        Answer answer = Answer.builder()
                .question(question)
                .content(similarAnswer)
                .build();

        answerRepository.save(answer);
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
