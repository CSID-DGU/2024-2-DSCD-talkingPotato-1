package org.dongguk.dscd.wooahan.api.core.annotation.valid;

import jakarta.validation.Constraint;
import jakarta.validation.Payload;
import org.dongguk.dscd.wooahan.api.core.validator.EnumValueValidator;

import java.lang.annotation.Documented;
import java.lang.annotation.*;

@Documented
@Retention(RetentionPolicy.RUNTIME)
@Constraint(validatedBy = EnumValueValidator.class)
@Target({ElementType.METHOD, ElementType.FIELD, ElementType.ANNOTATION_TYPE, ElementType.CONSTRUCTOR, ElementType.PARAMETER, ElementType.TYPE_USE})
public @interface EnumValue {

    String message() default "잘못된 Enum 값입니다.";

    Class<?>[] groups() default {};

    Class<? extends Payload>[] payload() default {};

    Class<? extends java.lang.Enum<?>> enumClass();
}
