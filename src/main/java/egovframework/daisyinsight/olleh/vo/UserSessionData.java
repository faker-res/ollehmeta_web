package egovframework.daisyinsight.olleh.vo;

import java.util.Map;

/**
 * Created by kth on 2018-02-20.
 */
public class UserSessionData {

    private Map<String, String> userSystemInfo;
    private Map<String, String> userLdapInfo;

    public Map<String, String> getUserSystemInfo() {
        return userSystemInfo;
    }

    public void setUserSystemInfo(Map<String, String> userSystemInfo) {
        this.userSystemInfo = userSystemInfo;
    }

    public Map<String, String> getUserLdapInfo() {
        return userLdapInfo;
    }
    public void setUserLdapInfo(Map<String, String> userLdapInfo) {
        this.userLdapInfo = userLdapInfo;
    }

    public String getUserName(){
        if ( userLdapInfo != null ) {
            return userLdapInfo.get("userName");
        } else {
            return "Unknown User";
        }
    }

    public String getUserId(){
        if ( userLdapInfo != null ) {
            return userLdapInfo.get("userId");
        } else {
            return "Unknown User";
        }
    }

    public Boolean isAdmin(){
        if ( userSystemInfo != null && "ADMIN".equalsIgnoreCase( userSystemInfo.get("GRANT") )) {
            return true;
        } else {
            return false;
        }
    }
}
