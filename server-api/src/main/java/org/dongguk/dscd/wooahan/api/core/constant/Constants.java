package org.dongguk.dscd.wooahan.api.core.constant;

import java.util.List;

public class Constants {

    // JWT
    public static final String ACCOUNT_ID_CLAIM_NAME = "aid";
    public static final String ACCOUNT_ROLE_CLAIM_NAME = "rol";

    public static final String PROVIDER_CLAIM_NAME = "pro";

    // HEADER
    public static final String BEARER_PREFIX = "Bearer ";
    public static final String AUTHORIZATION_HEADER = "Authorization";

    // COOKIE
    public static final String ACCOUNT_ID_ATTRIBUTE_NAME = "account_id";
    public static final String ACCESS_TOKEN_ATTRIBUTE_NAME = "access_token";
    public static final String REFRESH_TOKEN_ATTRIBUTE_NAME = "refresh_token";
    public static final String TEMPORARY_TOKEN_ATTRIBUTE_NAME = "temporary_token";

    public static class PublicPost {
        public static final List<String> URLS = List.of(
                // Security
                "/auth/login",
                "/auth/reissue/token",
                "/auth/reissue/password",
                "/auth/validations/email",
                "/auth/validations/authentication-code",
                "/auth/sign-up",

                // Notification
                "/v1/users/**"
        );
    }

    public static class PublicGet {
        public static final List<String> URLS = List.of();
    }

    public static class PublicPut {
        public static final List<String> URLS = List.of();
    }

    public static class PublicPatch {
        public static final List<String> URLS = List.of();
    }

    public static class PublicDelete {
        public static final List<String> URLS = List.of();
    }
}

