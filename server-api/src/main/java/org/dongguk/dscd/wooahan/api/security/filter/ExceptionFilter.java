package org.dongguk.dscd.wooahan.api.security.filter;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;
import org.dongguk.dscd.wooahan.api.core.exception.error.ErrorCode;
import org.dongguk.dscd.wooahan.api.core.exception.type.CommonException;
import org.dongguk.dscd.wooahan.api.core.exception.type.HttpJsonWebTokenException;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;

@Slf4j
public class ExceptionFilter extends OncePerRequestFilter {

    @Override
    protected void doFilterInternal(
            HttpServletRequest request,
            HttpServletResponse response,
            FilterChain filterChain
    ) throws ServletException, IOException {
        try {
            filterChain.doFilter(request, response);
        } catch (SecurityException e) {
            log.error("FilterException throw SecurityException : {}", e.getMessage());
            request.setAttribute("exception", ErrorCode.ACCESS_DENIED);
            filterChain.doFilter(request, response);
        } catch (HttpJsonWebTokenException e) {
            log.error("FilterException throw JsonWebTokenException : {}", e.getMessage());
            request.setAttribute("exception", e.getErrorCode());
            filterChain.doFilter(request, response);
        } catch (CommonException e) {
            log.error("FilterException throw CommonException : {}", e.getMessage());
            request.setAttribute("exception", e.getErrorCode());
            filterChain.doFilter(request, response);
        } catch (Exception e) {
            log.error("FilterException throw Exception : {}", e.getMessage());
            e.printStackTrace();
            request.setAttribute("exception", ErrorCode.INTERNAL_SERVER_ERROR);
            filterChain.doFilter(request, response);
        }
    }
}

