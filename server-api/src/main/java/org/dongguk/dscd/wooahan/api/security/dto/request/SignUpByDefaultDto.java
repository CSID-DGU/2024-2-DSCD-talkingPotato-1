package org.dongguk.dscd.wooahan.api.security.dto.request;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;

public record SignUpByDefaultDto(

        @JsonProperty("nickname")
        @NotBlank(message = "닉네임을 입력해주세요.")
        @Pattern(
                regexp = "^[a-zA-Z0-9가-힣]*$",
                message = "닉네임은 한글, 영어, 숫자만 입력 가능합니다."
        )
        String nickname,

        @JsonProperty("password")
        @NotBlank(message = "비밀번호를 입력해주세요.")
        @Pattern(
                regexp = "^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^&*])[a-zA-Z0-9!@#$%^&*]{8,20}$",
                message = "비밀번호는 8글자 이상 20자 이하로, 영어 대소문자, 숫자, 특수문자 중 3가지 이상을 조합하여 입력해주세요."
        )
        String password,

        @JsonProperty("career")
        String career
) {
}
