package egovframework.daisyinsight.common.base;

import egovframework.daisyinsight.olleh.vo.UserSessionData;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Created by kth on 2018-02-20.
 */
public class LoginCheckIntercepter extends HandlerInterceptorAdapter {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws IOException {

        // session�˻�

        HttpSession session = request.getSession(false);
        String requestUrl = request.getRequestURI();


        if (session == null) {

            try {

                if ( request.getQueryString() != null && !request.getQueryString().equalsIgnoreCase("null") ) {
                    requestUrl += "?&"+request.getQueryString();
                } else {
                    requestUrl = "/";
                }

                if ( requestUrl.equalsIgnoreCase("/v1/apis")) {
                    response.getWriter().write("apiSessionError");
                } else {
                    response.sendRedirect("/login.do");
                }

            } catch (IOException e) {
                e.printStackTrace();
            }
            return false;
        }

        UserSessionData memberVO = (UserSessionData)session.getAttribute("userLoginInfo");
        if (memberVO == null) {
            try {
                HttpSession sess = request.getSession();
                sess.invalidate();

                if ( requestUrl.equalsIgnoreCase("/v1/apis")) {
                    response.getWriter().write("apiSessionError");
                } else {
                    response.sendRedirect("/login.do");
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
            return false;
        } else {

        }
        return true;
    }
}
