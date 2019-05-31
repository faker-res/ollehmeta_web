package egovframework.daisyinsight.common.base;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by kth on 2018-04-24.
 */

public class WebFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain    ) throws IOException, ServletException {

        HttpServletResponse res = ((HttpServletResponse) response);
        //교차 프레임 스크립팅 방어 누락
        res.setHeader("X-Frame-Options", "SAMEORIGIN");
        //HTTP Strict-Transport-Security 헤더 누락
        res.setHeader("Strict-Transport-Security", "max-age=31536000; includeSubDomains; preload");
        //Missing "X-Content-Type-Options" header
        res.setHeader("X-Content-Type-Options", "nosniff");
        //Missing "X-XSS-Protection" header
        res.setHeader("X-XSS-Protection", "1");
        res.setHeader("Content-Security-Policy", "frame-ancestors 'self'");


        chain.doFilter(request, res);
    }

    @Override
    public void destroy() {

    }
}
