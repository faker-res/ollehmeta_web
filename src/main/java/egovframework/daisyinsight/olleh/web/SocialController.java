package egovframework.daisyinsight.olleh.web;

import egovframework.daisyinsight.common.base.CommonController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by kth on 2017-12-13.
 */
@Controller
public class SocialController extends CommonController {

    @RequestMapping(value = "/social.do")
    public ModelAndView biWebMain(HttpServletRequest request ) throws Exception
    {
        logger.debug( "## social " ) ;
        ModelAndView mav = new ModelAndView("social/social");
        return mav;
    }
}
