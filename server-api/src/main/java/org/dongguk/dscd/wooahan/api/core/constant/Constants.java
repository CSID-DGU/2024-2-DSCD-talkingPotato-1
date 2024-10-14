package org.dongguk.dscd.wooahan.api.core.constant;

import java.util.List;

public class Constants {

    // JWT
    public static String ACCOUNT_ID_ATTRIBUTE_NAME = "ACCOUNT_ID";
    public static String ACCOUNT_ID_CLAIM_NAME = "aid";
    public static String ACCOUNT_ROLE_CLAIM_NAME = "rol";

    public static String PROVIDER_CLAIM_NAME = "pro";

    // HEADER
    public static String BEARER_PREFIX = "Bearer ";
    public static String AUTHORIZATION_HEADER = "Authorization";

    // COOKIE
    public static String ACCESS_TOKEN = "access_token";
    public static String REFRESH_TOKEN = "refresh_token";

    /**
     * 인증이 필요 없는 URL
     */
    public static List<String> NO_NEED_AUTH_URLS = List.of(

            // Auth
            "/auth/validations/email",
            "/auth/validations/authentication-code",

            "/auth/reissue/token",
            "/auth/reissue/password",

            "/auth/sign-up",
            "/oauth/sign-up",

            "/auth/login",

            // Swagger
            "/api-docs.html",
            "/api-docs/**",
            "/swagger-ui/**",
            "/v3/**"
    );

    public static List<String> SWAGGER_URLS = List.of(
            "/api-docs.html",
            "/api-docs",
            "/swagger-ui",
            "/v3"
    );

    public static List<String> PUBLIC_URLS = List.of(
    );

    public static List<String> USER_URLS = List.of(
    );
}

