package org.dongguk.dscd.wooahan.api.core.annotation.valid;

import jakarta.validation.Constraint;
import jakarta.validation.Payload;
import org.dongguk.dscd.wooahan.api.core.validator.TimeValueValidator;

import java.lang.annotation.*;

@Documented
@Retention(RetentionPolicy.RUNTIME)
@Constraint(validatedBy = TimeValueValidator.class)
@Target({ElementType.PARAMETER, ElementType.FIELD})
public @interface TimeValue {

    String message() default "잘못된 데이터 형식입니다. (HH:mm)";

    Class<?>[] groups() default {};

    Class<? extends Payload>[] payload() default {};
}
