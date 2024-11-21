package org.dongguk.dscd.wooahan.api.security.config;

import lombok.RequiredArgsConstructor;
import org.dongguk.dscd.wooahan.api.core.constant.Constants;
import org.dongguk.dscd.wooahan.api.security.filter.ExceptionFilter;
import org.dongguk.dscd.wooahan.api.security.filter.JsonWebTokenAuthenticationFilter;
import org.dongguk.dscd.wooahan.api.security.handler.common.DefaultAccessDeniedHandler;
import org.dongguk.dscd.wooahan.api.security.handler.common.DefaultAuthenticationEntryPoint;
import org.dongguk.dscd.wooahan.api.security.handler.login.DefaultLoginFailureHandler;
import org.dongguk.dscd.wooahan.api.security.handler.login.DefaultLoginSuccessHandler;
import org.dongguk.dscd.wooahan.api.security.handler.logout.DefaultLogoutProcessHandler;
import org.dongguk.dscd.wooahan.api.security.handler.logout.DefaultLogoutSuccessHandler;
import org.dongguk.dscd.wooahan.api.security.usecase.AuthenticateJsonWebTokenUseCase;
import org.dongguk.dscd.wooahan.api.security.util.JsonWebTokenUtil;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.logout.LogoutFilter;

@Configuration
@EnableWebSecurity
@EnableMethodSecurity
@RequiredArgsConstructor
public class SecurityConfig {

    private final DefaultLoginSuccessHandler defaultLoginSuccessHandler;
    private final DefaultLoginFailureHandler defaultLoginFailureHandler;

    private final DefaultLogoutProcessHandler defaultLogoutProcessHandler;
    private final DefaultLogoutSuccessHandler defaultLogoutSuccessHandler;

    private final DefaultAccessDeniedHandler defaultAccessDeniedHandler;
    private final DefaultAuthenticationEntryPoint defaultAuthenticationEntryPoint;

    private final AuthenticateJsonWebTokenUseCase authenticateJsonWebTokenUseCase;
    private final JsonWebTokenUtil jsonWebTokenUtil;

    @Bean
    protected SecurityFilterChain securityFilterChain(HttpSecurity httpSecurity) throws Exception {
        return httpSecurity
                .csrf(AbstractHttpConfigurer::disable)

                .httpBasic(AbstractHttpConfigurer::disable)

                .sessionManagement(configurer -> configurer
                        .sessionCreationPolicy(SessionCreationPolicy.STATELESS)
                )

                .authorizeHttpRequests(configurer -> configurer
                        .requestMatchers(HttpMethod.POST, Constants.PublicPost.URLS.toArray(String[]::new)).permitAll()
                        .requestMatchers(HttpMethod.GET, Constants.PublicGet.URLS.toArray(String[]::new)).permitAll()
                        .requestMatchers(HttpMethod.PUT, Constants.PublicPut.URLS.toArray(String[]::new)).permitAll()
                        .requestMatchers(HttpMethod.PATCH, Constants.PublicPatch.URLS.toArray(String[]::new)).permitAll()
                        .requestMatchers(HttpMethod.DELETE, Constants.PublicDelete.URLS.toArray(String[]::new)).permitAll()
                        .anyRequest().authenticated()
                )

                .formLogin(configurer -> configurer
                        .loginPage("/login")
                        .loginProcessingUrl("/auth/login")
                        .usernameParameter("serial_id")
                        .passwordParameter("password")
                        .successHandler(defaultLoginSuccessHandler)
                        .failureHandler(defaultLoginFailureHandler)
                )

                .logout(configurer -> configurer
                        .logoutUrl("/auth/logout")
                        .addLogoutHandler(defaultLogoutProcessHandler)
                        .logoutSuccessHandler(defaultLogoutSuccessHandler)
                )

                .exceptionHandling(configurer -> configurer
                        .accessDeniedHandler(defaultAccessDeniedHandler)
                        .authenticationEntryPoint(defaultAuthenticationEntryPoint)
                )

                .addFilterBefore(
                        new JsonWebTokenAuthenticationFilter(
                                authenticateJsonWebTokenUseCase,
                                jsonWebTokenUtil
                        ),
                        LogoutFilter.class
                )

                .addFilterBefore(
                        new ExceptionFilter(),
                        JsonWebTokenAuthenticationFilter.class
                )

                .getOrBuild();
    }
}
