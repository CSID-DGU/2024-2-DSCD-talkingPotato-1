package org.dongguk.dscd.wooahan.api.core.utility;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;

/**
 * 날짜 및 시간 관련 유틸리티 클래스
 */
public class DateTimeUtil {

    public static final DateTimeFormatter ISODateTimeFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
    public static final DateTimeFormatter ISODateFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
    public static final DateTimeFormatter ISOTimeFormatter = DateTimeFormatter.ofPattern("HH:mm");

    /**
     * String을 LocalTime으로 변환
     *
     * @param time String
     * @return LocalTime
     */
    public static LocalTime convertStringToLocalTime(String time) {
        return LocalTime.parse(time, ISOTimeFormatter);
    }

    /**
     * LocalTime을 String으로 변환
     *
     * @param time LocalTime
     * @return String
     */
    public static String convertLocalTimeToString(LocalTime time) {
        return time.format(ISOTimeFormatter);
    }

    /**
     * String을 LocalDate로 변환
     *
     * @param date String
     * @return LocalDate
     */
    public static LocalDate convertStringToLocalDate(String date) {
        return LocalDate.parse(date, ISODateFormatter);
    }

    /**
     * LocalDate를 String으로 변환
     *
     * @param date LocalDate
     * @return String
     */
    public static String convertLocalDateToString(LocalDate date) {
        return date.format(ISODateFormatter);
    }

    /**
     * String을 LocalDateTime으로 변환
     *
     * @param date String
     * @return LocalDateTime
     */
    public static LocalDateTime convertStringToLocalDateTime(String date) {
        return LocalDateTime.parse(date, ISODateTimeFormatter);
    }

    /**
     * LocalDateTime을 String으로 변환
     *
     * @param date LocalDateTime
     * @return String
     */
    public static String convertLocalDateTimeToString(LocalDateTime date) {
        return date.format(ISODateTimeFormatter);
    }
}
