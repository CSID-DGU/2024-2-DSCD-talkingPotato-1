package org.dongguk.dscd.wooahan.api.security.filter;

import io.jsonwebtoken.Claims;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import org.dongguk.dscd.wooahan.api.core.constant.Constants;
import org.dongguk.dscd.wooahan.api.core.exception.error.ErrorCode;
import org.dongguk.dscd.wooahan.api.core.exception.type.CommonException;
import org.dongguk.dscd.wooahan.api.security.domain.type.ERole;
import org.dongguk.dscd.wooahan.api.security.info.UserPrincipal;
import org.dongguk.dscd.wooahan.api.security.usecase.AuthenticateJsonWebTokenUseCase;
import org.dongguk.dscd.wooahan.api.security.util.HeaderUtil;
import org.dongguk.dscd.wooahan.api.security.util.JsonWebTokenUtil;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.util.AntPathMatcher;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;
import java.util.UUID;

@RequiredArgsConstructor
public class JsonWebTokenAuthenticationFilter extends OncePerRequestFilter {

    private final AuthenticateJsonWebTokenUseCase authenticateJsonWebTokenUseCase;

    private final JsonWebTokenUtil jsonWebTokenUtil;

    private static final AntPathMatcher antPathMatcher = new AntPathMatcher();

    @Override
    protected void doFilterInternal(
            HttpServletRequest request,
            HttpServletResponse response,
            FilterChain filterChain
    ) throws ServletException, IOException {
        String token = HeaderUtil.refineHeader(request, Constants.AUTHORIZATION_HEADER, Constants.BEARER_PREFIX)
                .orElseThrow(() -> new CommonException(ErrorCode.INVALID_HEADER_FORMAT));

        Claims claims = jsonWebTokenUtil.validateToken(token);

        UUID accountId = UUID.fromString(claims.get(Constants.ACCOUNT_ID_CLAIM_NAME, String.class));
        ERole role = ERole.fromString(claims.get(Constants.ACCOUNT_ROLE_CLAIM_NAME, String.class));

        UserPrincipal principal = authenticateJsonWebTokenUseCase.execute(accountId);

        if (!role.equals(principal.getRole())) {
            throw new CommonException(ErrorCode.ACCESS_DENIED);
        }

        // AuthenticationToken 생성
        UsernamePasswordAuthenticationToken authenticationToken = new UsernamePasswordAuthenticationToken(
                principal,
                null,
                principal.getAuthorities()
        );

        // SecurityContext에 AuthenticationToken 저장
        authenticationToken.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));

        SecurityContext context = SecurityContextHolder.createEmptyContext();
        context.setAuthentication(authenticationToken);
        SecurityContextHolder.setContext(context);

        // 다음 필터로 전달
        filterChain.doFilter(request, response);
    }

    @Override
    protected boolean shouldNotFilter(HttpServletRequest request) {
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

