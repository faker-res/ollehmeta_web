package egovframework.daisyinsight.olleh.rest;

import com.fasterxml.jackson.databind.ObjectMapper;
import egovframework.daisyinsight.common.base.CommonController;
import egovframework.daisyinsight.common.util.DateUtil;
import egovframework.daisyinsight.common.util.HttpClientUtil;
import org.apache.http.NameValuePair;
import org.apache.http.client.utils.URLEncodedUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.nio.charset.Charset;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by kth on 2018-01-08.
 */
@RestController
public class OllehMetaController  extends CommonController {

    @Autowired
    private HttpClientUtil httpClientUtil;

    @ResponseBody
    @RequestMapping(value = "/v1/apis", produces = "application/json; charset=utf8")
    public String apis(HttpServletRequest request ) throws Exception
    {
        String apiInfo   = request.getParameter("apiUrl");
        String apiParam  = request.getParameter("apiParam");

        HashMap<String,Object> apiInfoMap = new ObjectMapper().readValue(apiInfo, HashMap.class);
        HashMap<String,Object> apiParamMap = new ObjectMapper().readValue(apiParam, HashMap.class);

        String response = httpClientUtil.requestOllehMeta(apiInfoMap, apiParamMap);
        return response;
    }

    @ResponseBody
    @RequestMapping(value = "/v1/daumsoft/insta/sns", produces = "application/json; charset=utf8")
    public String daumsoftInstaSns(HttpServletRequest request ) throws Exception
    {
        String movieName  = request.getParameter("movieName");

        String instagramApi = "http://kt-api.some.co.kr/TrendMap/JSON/ServiceHandler?command=GetKeywordAssociation&lang=ko&source=insta&startDate=|STARTDATE|&endDate=|ENDDATE|&categorySetName=SM&topN=10&keywordFilterList[]=+(영화)&keyword=|MOVIENAME|&categoryList[]=123/0/0";

        instagramApi.replaceAll("|STARTDATE|", DateUtil.getYearAgoDateString());
        instagramApi.replaceAll("|ENDDATE|", DateUtil.getYesterdayDateString());
        instagramApi.replaceAll("|MOVIENAME|", movieName);

        String instagramResponse = httpClientUtil.get(instagramApi);
        //return HttpClientUtil.requestOllehMeta(apiInfoMap, apiParamMap);

        return instagramResponse;
    }

    @ResponseBody
    @RequestMapping(value = "/v1/daumsoft/twitter/sns", produces = "application/json; charset=utf8")
    public String daumsoftTwitterSns(HttpServletRequest request ) throws Exception
    {
        String movieName  = request.getParameter("movieName");
        String twitterApi   = "http://kt-api.some.co.kr/TrendMap/JSON/ServiceHandler?command=GetKeywordAssociation&lang=ko&source=twitter&startDate=|STARTDATE|&endDate=|ENDDATE|&categorySetName=SM&topN=10&keywordFilterList[]=+(영화)&keyword=|MOVIENAME|&categoryList[]=123/0/0";

        twitterApi.replaceAll("|STARTDATE|", DateUtil.getYearAgoDateString());
        twitterApi.replaceAll("|ENDDATE|", DateUtil.getYesterdayDateString());
        twitterApi.replaceAll("|MOVIENAME|", movieName);

        String twitterResponse = httpClientUtil.get(twitterApi);
        //return HttpClientUtil.requestOllehMeta(apiInfoMap, apiParamMap);

        return twitterResponse;
    }
}
