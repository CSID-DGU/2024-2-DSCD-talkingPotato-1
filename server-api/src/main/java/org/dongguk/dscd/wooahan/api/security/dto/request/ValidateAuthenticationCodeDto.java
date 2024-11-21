package org.dongguk.dscd.wooahan.api.security.dto.request;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import org.hibernate.validator.constraints.Length;

public record ValidateAuthenticationCodeDto(
        @JsonProperty("email")
        @NotBlank(message = "이메일을 입력해주세요.")
        @Pattern(
                regexp = "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,6}$",
                message = "잘못된 이메일 형식입니다."
        )
        String email,

        @JsonProperty("authentication_code")
        @NotBlank(message = "인증 코드를 입력해주세요.")
        @Length(min = 6, max = 6, message = "인증 코드는 6자리로 입력해주세요.")
        String authenticationCode
) {
}
