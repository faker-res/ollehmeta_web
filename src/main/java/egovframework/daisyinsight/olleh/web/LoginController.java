package egovframework.daisyinsight.olleh.web;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.sun.org.apache.xerces.internal.impl.dv.util.Base64;
import egovframework.daisyinsight.common.base.CommonController;
import egovframework.daisyinsight.common.util.HttpClientUtil;
import egovframework.daisyinsight.olleh.service.LoginService;
import egovframework.daisyinsight.olleh.vo.UserSessionData;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by kth on 2018-02-20.
 */
@Controller
public class LoginController extends CommonController {

    private final String AUTH_GOOD = "200";
    private final String AUTH_FAIL_SYSTEM = "1001";
    private final String AUTH_FAIL_PASS_ERROR = "1002";
    private String userLoginInfo =  "userLoginInfo" ;
    @Autowired
    private LoginService loginService;

    @Autowired
    private HttpClientUtil httpClientUtil;

    @RequestMapping(value = "/login.do")
    public ModelAndView login(HttpSession session)
    {

        logger.debug( "## login " ) ;
        ModelAndView mav = new ModelAndView("common/login");
        return mav;
    }

    @RequestMapping(value = "/loginProcess.do", method = RequestMethod.POST)
    @ResponseBody
    public String loginProcess(HttpServletRequest request, HttpSession session )
    {


        logger.debug( "## loginProcess " ) ;
        String userId = request.getParameter("userId");
        String passwordStr = request.getParameter("password");

        HashMap<String,String> userSystemInfo = new HashMap<String,String>();

        try {
            passwordStr = URLDecoder.decode(passwordStr, "UTF-8");

            HashMap<String,Object> paramMap = new HashMap<String,Object>();
            paramMap.put("hash", "sdjnfio2390dsvjklwwe90jf2");
            paramMap.put("custid", "ollehmeta");
            paramMap.put("userid", userId);

            String reponseString = httpClientUtil.Post("/auth/user/login", paramMap);
            HashMap<String,Object> responseMap = null;
            try {
                responseMap = new ObjectMapper().readValue(reponseString, HashMap.class);
            } catch (IOException e) {
                e.printStackTrace();
            }

            HashMap<String,Object> userAuthInfo  = loginService.userAuthInfo(userId);
            if ( userAuthInfo == null ) {
                return AUTH_FAIL_SYSTEM;
            }
            userSystemInfo.put("GRANT", (String)userAuthInfo.get("GRANT"));

            if ( userSystemInfo == null ) {
                return AUTH_FAIL_SYSTEM;
            }

            String password = (String)userAuthInfo.get("PASSWORD");
            String base64DecodingPwd = new String(Base64.decode(password));

            if ( !base64DecodingPwd.equals(passwordStr)) {
                return AUTH_FAIL_PASS_ERROR;
            }

            Map<String, String> userInfoMap = loginService.userInfo(userId);
            if ( userInfoMap == null ) {
                return AUTH_FAIL_PASS_ERROR;
            }

            UserSessionData userSessionData = new UserSessionData();
            userSessionData.setUserLdapInfo(userInfoMap);
            userSessionData.setUserSystemInfo(userSystemInfo);

            session.setAttribute(userLoginInfo, userSessionData);

        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }

        return AUTH_GOOD;
    }

    /**
     * �α� �ƿ�
     *
     * @param session
     */
    @RequestMapping(value = "/logout.do", method = RequestMethod.GET)
    public void logout(HttpServletResponse response, HttpSession session) {

        try {
            UserSessionData userDetails = (UserSessionData) session.getAttribute(userLoginInfo);

            logger.info("Welcome logout! {}, {}", session.getId(), "a");
            session.setAttribute(userLoginInfo, null);
            session.invalidate();
            response.sendRedirect("/login.do");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
