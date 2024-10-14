package org.dongguk.dscd.wooahan.api.core.annotation.valid;

import jakarta.validation.Constraint;
import jakarta.validation.Payload;
import org.dongguk.dscd.wooahan.api.core.validator.DateTimeValueValidator;

import java.lang.annotation.*;

@Documented
@Retention(RetentionPolicy.RUNTIME)
@Constraint(validatedBy = DateTimeValueValidator.class)
@Target({ElementType.PARAMETER, ElementType.FIELD})
public @interface DateTimeValue {

    String message() default "잘못된 데이터 형식입니다. (yyyy-MM-dd HH:mm:ss)";

    Class<?>[] groups() default {};

    Class<? extends Payload>[] payload() default {};
}
