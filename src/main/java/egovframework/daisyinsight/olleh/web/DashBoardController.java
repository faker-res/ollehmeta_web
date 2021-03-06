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
public class DashBoardController extends CommonController {

    @RequestMapping(value = "/dashboard.do")
    public ModelAndView biWebMain(HttpServletRequest request ) throws Exception
    {
        logger.debug( "## dashboard " ) ;

        ModelAndView mav = new ModelAndView("dashboard/dashboard");
        return mav;
    }
}
