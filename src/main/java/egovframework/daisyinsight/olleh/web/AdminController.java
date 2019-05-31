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
public class AdminController extends CommonController {

    @RequestMapping(value = "/admin/admin.do")
    public ModelAndView UserManager(HttpServletRequest request ) throws Exception
    {
        logger.debug( "## admin " ) ;
        ModelAndView mav = new ModelAndView("admin/admin");
        return mav;
    }
    @RequestMapping(value = "/admin/dataview.do")
    public ModelAndView dataView(HttpServletRequest request ) throws Exception
    {
        logger.debug( "## data view " ) ;
        ModelAndView mav = new ModelAndView("admin/dataview");
        return mav;
    }
}
