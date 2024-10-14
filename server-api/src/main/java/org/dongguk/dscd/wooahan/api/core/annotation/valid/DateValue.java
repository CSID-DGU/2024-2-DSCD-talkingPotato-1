package org.dongguk.dscd.wooahan.api.core.annotation.valid;

import jakarta.validation.Constraint;
import jakarta.validation.Payload;
import org.dongguk.dscd.wooahan.api.core.validator.DateValueValidator;

import java.lang.annotation.*;

@Documented
@Retention(RetentionPolicy.RUNTIME)
@Constraint(validatedBy = DateValueValidator.class)
@Target({ElementType.PARAMETER, ElementType.FIELD})
public @interface DateValue {

    String message() default "잘못된 데이터 형식입니다. (yyyy-MM-dd)";

    Class<?>[] groups() default {};

    Class<? extends Payload>[] payload() default {};
}
