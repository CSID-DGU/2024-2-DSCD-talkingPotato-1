package org.dongguk.dscd.wooahan.api.security.util;

import io.jsonwebtoken.*;
import io.jsonwebtoken.io.Decoders;
import io.jsonwebtoken.security.Keys;
import lombok.Getter;
import org.dongguk.dscd.wooahan.api.core.constant.Constants;
import org.dongguk.dscd.wooahan.api.core.exception.error.ErrorCode;
import org.dongguk.dscd.wooahan.api.core.exception.type.CommonException;
import org.dongguk.dscd.wooahan.api.core.exception.type.HttpJsonWebTokenException;
import org.dongguk.dscd.wooahan.api.security.domain.type.EProvider;
import org.dongguk.dscd.wooahan.api.security.domain.type.ERole;
import org.dongguk.dscd.wooahan.api.security.dto.response.DefaultJsonWebTokenDto;
import org.dongguk.dscd.wooahan.api.security.dto.response.TemporaryJsonWebTokenDto;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.security.Key;
import java.util.Date;
import java.util.UUID;

@Component
public class JsonWebTokenUtil implements InitializingBean {

    @Value("${json-web-token.secret-key}")
    private String secretKey;

    @Value("${json-web-token.temporary-token-expire-period}")
    private Long temporaryTokenExpirePeriod;

    @Value("${json-web-token.access-token-expire-period}")
    private Long accessTokenExpirePeriod;

    @Getter @Value("${json-web-token.refresh-token-expire-period}")
    private Long refreshTokenExpirePeriod;

    private Key key;

    @Override
    public void afterPropertiesSet() {
        byte[] keyBytes = Decoders.BASE64.decode(secretKey);
        this.key = Keys.hmacShaKeyFor(keyBytes);
    }

    public Claims validateToken(String token) {
        try {
            return Jwts.parserBuilder()
                    .setSigningKey(key)
                    .build()
                    .parseClaimsJws(token)
                    .getBody();
        } catch (MalformedJwtException e) {
            throw new HttpJsonWebTokenException(e.getMessage(), ErrorCode.TOKEN_MALFORMED_ERROR);
        } catch (IllegalArgumentException e) {
            throw new HttpJsonWebTokenException(e.getMessage(), ErrorCode.TOKEN_TYPE_ERROR);
        } catch (ExpiredJwtException e) {
            throw new HttpJsonWebTokenException(e.getMessage(), ErrorCode.TOKEN_EXPIRED_ERROR);
        } catch (UnsupportedJwtException e) {
            throw new HttpJsonWebTokenException(e.getMessage(), ErrorCode.TOKEN_UNSUPPORTED_ERROR);
        } catch (JwtException e) {
            throw new HttpJsonWebTokenException(e.getMessage(), ErrorCode.TOKEN_UNKNOWN_ERROR);
        } catch (Exception e) {
            throw new CommonException(ErrorCode.INTERNAL_SERVER_ERROR);
        }
    }

    public DefaultJsonWebTokenDto generateDefaultJsonWebTokens(
            UUID id,
            ERole role
    ) {
        return new DefaultJsonWebTokenDto(
                generateDefaultToken(id.toString(), role, accessTokenExpirePeriod),
                generateDefaultToken(id.toString(), null, refreshTokenExpirePeriod)
        );
    }

    public TemporaryJsonWebTokenDto generateTemporaryJsonWebToken(
            String serialId,
            EProvider provider
    ) {
        Claims claims = Jwts.claims();

        claims.put(Constants.ACCOUNT_ID_CLAIM_NAME, serialId);
        claims.put(Constants.PROVIDER_CLAIM_NAME, provider);

        return TemporaryJsonWebTokenDto.builder()
                .temporaryToken(
                        Jwts.builder()
                            .setHeaderParam(Header.JWT_TYPE, Header.JWT_TYPE)
                            .setClaims(claims)
                            .setIssuedAt(new Date(System.currentTimeMillis()))
                            .setExpiration(new Date(System.currentTimeMillis() + temporaryTokenExpirePeriod))
                            .signWith(key, SignatureAlgorithm.HS512)
                            .compact()
                )
                .build();
    }

    private String generateDefaultToken(
            String identifier,
            ERole role,
            Long expirePeriod
    ) {
        Claims claims = Jwts.claims();

        claims.put(Constants.ACCOUNT_ID_CLAIM_NAME, identifier);

        if (role != null)
            claims.put(Constants.ACCOUNT_ROLE_CLAIM_NAME, role);

        return Jwts.builder()
                .setHeaderParam(Header.JWT_TYPE, Header.JWT_TYPE)
                .setClaims(claims)
                .setIssuedAt(new Date(System.currentTimeMillis()))
                .setExpiration(new Date(System.currentTimeMillis() + expirePeriod))
                .signWith(key, SignatureAlgorithm.HS512)
                .compact();
    }
}
