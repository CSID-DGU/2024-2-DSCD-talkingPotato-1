package org.dongguk.dscd.wooahan.api.core.interceptor.pre;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.dongguk.dscd.wooahan.api.core.constant.Constants;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.util.AntPathMatcher;
import org.springframework.web.servlet.HandlerInterceptor;

@Component
public class AccountIDInterceptor implements HandlerInterceptor {

    private static final AntPathMatcher antPathMatcher = new AntPathMatcher();

    @Override
    public boolean preHandle(
            HttpServletRequest request,
            HttpServletResponse response,
            Object handler
    ) throws Exception {
        if (!isPublicUrl(request)) {
            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

            request.setAttribute(Constants.ACCOUNT_ID_ATTRIBUTE_NAME, authentication.getName());
        }

        return HandlerInterceptor.super.preHandle(request, response, handler);
    }

    private Boolean isPublicUrl(HttpServletRequest request) {
        Boolean isPublicPostUrl = "POST".equals(request.getMethod()) &&
                Constants.PublicPost.URLS.stream().anyMatch(url -> antPathMatcher.match(url, request.getRequestURI()));

        Boolean isPublicGetUrl = "GET".equals(request.getMethod()) &&
                Constants.PublicGet.URLS.stream().anyMatch(url -> antPathMatcher.match(url, request.getRequestURI()));

        Boolean isPublicPutUrl = "PUT".equals(request.getMethod()) &&
                Constants.PublicPut.URLS.stream().anyMatch(url -> antPathMatcher.match(url, request.getRequestURI()));

        Boolean isPublicPatchUrl = "PATCH".equals(request.getMethod()) &&
                Constants.PublicPatch.URLS.stream().anyMatch(url -> antPathMatcher.match(url, request.getRequestURI()));

        Boolean isPublicDeleteUrl = "DELETE".equals(request.getMethod()) &&
                Constants.PublicDelete.URLS.stream().anyMatch(url -> antPathMatcher.match(url, request.getRequestURI()));

        return isPublicPostUrl || isPublicGetUrl || isPublicPutUrl || isPublicPatchUrl || isPublicDeleteUrl;
    }
}
