package org.dongguk.dscd.wooahan.api.core.validator;

import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;
import org.dongguk.dscd.wooahan.api.core.annotation.valid.DateTimeValue;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;

public class DateTimeValueValidator implements ConstraintValidator<DateTimeValue, String> {

    private static final DateTimeFormatter DATE_FORMATTER = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

    @Override
    public void initialize(DateTimeValue constraintAnnotation) {
        ConstraintValidator.super.initialize(constraintAnnotation);
    }

    @Override
    public boolean isValid(String value, ConstraintValidatorContext context) {
        if (value == null) {
            return false;
        }

        try {
            LocalDateTime.parse(value, DATE_FORMATTER);
        } catch(DateTimeParseException e) {
            return false;
        }

        return true;
    }
}
