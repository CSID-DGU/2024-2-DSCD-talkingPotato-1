package org.dongguk.dscd.wooahan.api.core.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Getter;
import org.dongguk.dscd.wooahan.api.core.exception.error.ErrorCode;

@Getter
@Schema(description = "예외 정보")
public sealed class ExceptionDto permits ArgumentNotValidExceptionDto {

    @JsonProperty("code")
    @Schema(description = "예외 코드", example = "40010")
    private final Integer code;

    @JsonProperty("message")
    @Schema(description = "예외 메시지", example = "Bad Request")
    private final String message;

    public ExceptionDto(ErrorCode errorCode) {
        this.code = errorCode.getCode();
        this.message = errorCode.getMessage();
    }

    public ExceptionDto(Integer code, String message) {
        this.code = code;
        this.message = message;
    }

    public static ExceptionDto of(ErrorCode errorCode) {
        return new ExceptionDto(errorCode.getCode(), errorCode.getMessage());
    }

    public static ExceptionDto of(ErrorCode errorCode, String message) {
        return new ExceptionDto(errorCode.getCode(), message);
    }
}
