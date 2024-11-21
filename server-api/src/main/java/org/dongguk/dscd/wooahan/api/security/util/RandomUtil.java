package org.dongguk.dscd.wooahan.api.security.util;

/**
 * Utility class for generating authentication codes
 */
public class RandomUtil {

    /**
     * Generate a random password
     * @return The generated password
     */
    public static String generatePassword(Integer length) {
        StringBuilder password = new StringBuilder();

        // 비밀번호 생성
        for (int i = 0; i < length; i++) {
            int random = (int) (Math.random() * 4);
            switch (random) {
                case 0:
                    password.append((char) ((int) (Math.random() * 26) + 65));
                    break;
                case 1:
                    password.append((char) ((int) (Math.random() * 26) + 97));
                    break;
                case 2:
                    password.append((int) (Math.random() * 10));
                    break;
                case 3:
                    password.append("!@#$%^&*".charAt((int) (Math.random() * 8)));
                    break;
            }
        }

        return password.toString();
    }

    /**
     * Generate a random authentication code with the given length
     * @param length The length of the authentication code
     * @return The generated authentication code
     */
    public static String generateAuthCode(Integer length) {
        StringBuilder authCode = new StringBuilder();

        for (int i = 0; i < length; i++) {
            authCode.append((int) (Math.random() * 10));
        }

        return authCode.toString();
    }
}
