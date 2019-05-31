package egovframework.daisyinsight.olleh.service;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import egovframework.daisyinsight.common.util.HttpClientUtil;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

/**
 * Created by kth on 2018-02-20.
 */
@Service
public class LoginService {

    @Autowired
    private HttpClientUtil httpClientUtil;

    @Value("#{config['kt.ldap.host']}")
    private String ktLdapHost;
    @Value("#{config['kt.ldap.port']}")
    private String ktLdapPort;
    @Value("#{config['kt.ldap.baseDN']}")
    private String ktLdapBaseDN;
    @Value("#{config['kt.ldap.connID']}")
    private String ktLdapConnId;
    @Value("#{config['kt.ldap.connPwd']}")
    private String ktLdapConnPwd;
    @Value("#{config['kt.ldap.expiredPwdUrl']}")
    private String ktLdapExpiredPwdUrl;

    public Map<String, String> checkValidUser(String userId, String password) {

        if ("system".equalsIgnoreCase(userId) && password.equals("system.")) {
            Map<String, String> userInfo = new HashMap<String, String>();
            userInfo.put("userName", "데이지");                //이름
            userInfo.put("deptCD", "소속 팀 코드");            //소속 팀 코드
            userInfo.put("deptName", "소속 팀 명");             //소속 팀 명
            userInfo.put("agencyCD", "소속 본부 코드");           //소속 본부 코드
            userInfo.put("agencyName", "소속 본부 명");          //소속 본부 명
            userInfo.put("positionCD", "그룹사 코드 | 본부 코드 | 팀 코드");        //그룹사 코드 | 본부 코드 | 팀 코드
            userInfo.put("positionName", "그룹사명 본부명 팀명");    //그룹사명 본부명 팀명
            userInfo.put("companyCD", "회사코드");        //회사코드
            userInfo.put("companyName", "회사명");        //회사명
            userInfo.put("email", "email");            //email
            userInfo.put("mobile", "모바일 번호");            //모바일 번호
            return userInfo;
        } else {
            return null;
        }

        /*
        Map<String, String> userInfo = new HashMap<String, String>();
        try {
            userInfo = ADUtilSSL.query_userinfo(ktLdapHost, ktLdapPort, ktLdapBaseDN, userId, ktLdapConnId, ktLdapConnPwd, true);
        } catch (Exception e1) {
            e1.printStackTrace();
            return null;
        }
        /*
        String userName = (String) userInfo.get("userName");        //이름
        String deptCD = (String) userInfo.get("deptCD");            //소속 팀 코드
        String deptName = (String) userInfo.get("deptName");        //소속 팀 명
        String agencyCD = (String) userInfo.get("agencyCD");        //소속 본부 코드
        String agencyName = (String) userInfo.get("agencyName");        //소속 본부 명
        String positionCD = (String) userInfo.get("positionCD");        //그룹사 코드 | 본부 코드 | 팀 코드
        String positionName = (String) userInfo.get("positionName");    //그룹사명 본부명 팀명
        String companyCD = (String) userInfo.get("companyCD");        //회사코드
        String companyName = (String) userInfo.get("companyName");        //회사명
        String email = (String) userInfo.get("email");            //email
        String cellNum = (String) userInfo.get("mobile");            //모바일 번호
        String description = "";
        */

        //return userInfo;
    }

    public Map<String, String> userInfo(String userId) {

        String userListResponse = null;
        try {
            userListResponse = httpClientUtil.sendGet("/auth/user/list", "?&custid=" + userId );
            JSONParser parser = new JSONParser();
            JSONObject jsonObject = new JSONObject();

            jsonObject = (JSONObject) parser.parse(userListResponse);
            JSONArray jsonResultObject = (JSONArray) jsonObject.get("RESULT");
            Iterator<JSONObject> iterator = jsonResultObject.iterator();
            while (iterator.hasNext()) {
                JSONObject jsonUserObject = iterator.next();

                if ( jsonUserObject.get("USERID").equals(userId)) {
                    Map<String, String> userInfo = new HashMap<String, String>();
                    userInfo.put("userId", userId);
                    userInfo.put("userName", (String) jsonUserObject.get("NAME"));                //이름
                    userInfo.put("deptCD", "소속 팀 코드");            //소속 팀 코드
                    userInfo.put("deptName", "소속 팀 명");             //소속 팀 명
                    userInfo.put("agencyCD", "소속 본부 코드");           //소속 본부 코드
                    userInfo.put("agencyName", "소속 본부 명");          //소속 본부 명
                    userInfo.put("positionCD", "그룹사 코드 | 본부 코드 | 팀 코드");        //그룹사 코드 | 본부 코드 | 팀 코드
                    userInfo.put("positionName", "그룹사명 본부명 팀명");    //그룹사명 본부명 팀명
                    userInfo.put("companyCD", "회사코드");        //회사코드
                    userInfo.put("companyName", (String) jsonUserObject.get("COMPANY"));        //회사명
                    userInfo.put("email", "email");            //email
                    userInfo.put("mobile", "모바일 번호");            //모바일 번호
                    return userInfo;
                }

            }

        } catch (IOException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    public HashMap<String,Object> userAuthInfo(String userId) {

        HashMap<String,Object> resultMap = new HashMap<String,Object>();

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

        ObjectMapper mapper = new ObjectMapper();
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            JSONParser parser = new JSONParser();
            JSONObject jsonObject = new JSONObject();

            jsonObject = (JSONObject) parser.parse(reponseString);
            JSONObject jsonResultObject = (JSONObject) jsonObject.get("RESULT");

            resultMap.put("GRANT", (String) jsonResultObject.get("GRANT"));
            resultMap.put("PASSWORD", (String) jsonResultObject.get("PASSWORD"));
            return resultMap;

        }catch (ParseException e) {
            e.printStackTrace();
        }
        return null;
    }

}
