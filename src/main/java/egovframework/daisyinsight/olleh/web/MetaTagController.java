package egovframework.daisyinsight.olleh.web;

import egovframework.daisyinsight.common.base.CommonController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by kth on 2017-12-13.
 */
@Controller
public class MetaTagController extends CommonController {

    @RequestMapping(value = "/metatag.do")
    public ModelAndView biWebMain(HttpServletRequest request ) throws Exception
    {
        logger.debug( "## metatag " ) ;
        Map<String, String> paramMap = new HashMap<String, String>();
        String searchType = request.getParameter("searchType");
        if ( searchType == null ) {
            searchType = "ALL";
        }
        paramMap.put("searcyType", searchType);

        ModelAndView mav = new ModelAndView("metatag/metatag", paramMap);
        return mav;
    }
}
