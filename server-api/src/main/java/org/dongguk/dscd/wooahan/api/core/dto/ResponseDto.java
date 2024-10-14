package org.dongguk.dscd.wooahan.api.core.dto;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.annotation.Nullable;
import jakarta.validation.ConstraintViolationException;
import jakarta.validation.UnexpectedTypeException;
import lombok.Builder;
import org.dongguk.dscd.wooahan.api.core.exception.error.ErrorCode;
import org.dongguk.dscd.wooahan.api.core.exception.type.CommonException;
import org.dongguk.dscd.wooahan.api.core.exception.type.HttpJsonWebTokenException;
import org.springframework.http.HttpStatus;
import org.springframework.validation.method.MethodValidationResult;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.MissingServletRequestParameterException;
import org.springframework.web.method.annotation.HandlerMethodValidationException;
import org.springframework.web.method.annotation.MethodArgumentTypeMismatchException;

@Builder
public record ResponseDto<T>(
        @JsonIgnore
        HttpStatus httpStatus,

        @JsonProperty("status")
        Boolean success,

        @JsonProperty("data")
        T data,

        @JsonProperty("error")
        ExceptionDto error
) {
    public static <T> ResponseDto<T> ok(@Nullable final T data) {
        return ResponseDto.<T>builder()
                .httpStatus(HttpStatus.OK)
                .success(true)
                .data(data)
                .error(null)
                .build();
    }

    public static <T> ResponseDto<T> created(@Nullable final T data) {
        return ResponseDto.<T>builder()
                .httpStatus(HttpStatus.CREATED)
                .success(true)
                .data(data)
                .error(null)
                .build();
    }

    public static ResponseDto<Object> noContent() {
        return ResponseDto.<Object>builder()
                .httpStatus(HttpStatus.NO_CONTENT)
                .success(true)
                .data(null)
                .error(null)
                .build();
    }

    public static ResponseDto<Object> fail(ConstraintViolationException e) {
        return ResponseDto.<Object>builder()
                .httpStatus(HttpStatus.BAD_REQUEST)
                .success(false)
                .data(null)
                .error(new ArgumentNotValidExceptionDto(e))
                .build();
    }

    public static ResponseDto<?> fail(HandlerMethodValidationException e) {
        return ResponseDto.<Object>builder()
                .httpStatus(HttpStatus.BAD_REQUEST)
                .success(false)
                .data(null)
                .error(new ArgumentNotValidExceptionDto(e))
                .build();
    }

    public static ResponseDto<Object> fail(UnexpectedTypeException e) {
        return ResponseDto.<Object>builder()
                .httpStatus(HttpStatus.INTERNAL_SERVER_ERROR)
                .success(false)
                .data(null)
                .error(ExceptionDto.of(ErrorCode.INVALID_PARAMETER_FORMAT))
                .build();
    }

    public static <T> ResponseDto<T> fail(MethodArgumentNotValidException e) {
        return ResponseDto.<T>builder()
                .httpStatus(HttpStatus.BAD_REQUEST)
                .success(false)
                .data(null)
                .error(new ArgumentNotValidExceptionDto(e))
                .build();
    }

    public static ResponseDto<Object> fail(MissingServletRequestParameterException e) {
        return ResponseDto.<Object>builder()
                .httpStatus(HttpStatus.BAD_REQUEST)
                .success(false)
                .data(null)
                .error(ExceptionDto.of(ErrorCode.MISSING_REQUEST_PARAMETER))
                .build();
    }

    public static ResponseDto<Object> fail(MethodArgumentTypeMismatchException e) {
        return ResponseDto.<Object>builder()
                .httpStatus(HttpStatus.BAD_REQUEST)
                .success(false)
                .data(null)
                .error(ExceptionDto.of(ErrorCode.INVALID_PARAMETER_FORMAT))
                .build();
    }

    public static ResponseDto<Object> fail(HttpJsonWebTokenException e) {
        return ResponseDto.<Object>builder()
                .httpStatus(e.getErrorCode().getHttpStatus())
                .success(false)
                .data(null)
                .error(ExceptionDto.of(e.getErrorCode()))
                .build();
    }

    public static ResponseDto<Object> fail(CommonException e) {
        return ResponseDto.<Object>builder()
                .httpStatus(e.getErrorCode().getHttpStatus())
                .success(false)
                .data(null)
                .error(ExceptionDto.of(e.getErrorCode()))
                .build();
    }
}
