package egovframework.daisyinsight.olleh.web;

import egovframework.daisyinsight.common.base.CommonController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by kth on 2017-12-13.
 */
@Controller
public class RelKnowledgeController extends CommonController {

    final String seperator = "\t";
    final String lineFeed = System.getProperty("line.separator");
    
    @RequestMapping(value = "/relknowledge.do")
    public ModelAndView biWebMain(HttpServletRequest request ) throws Exception
    {
        logger.debug( "## relknowledge " ) ;
        Map<String, String> paramMap = new HashMap<String, String>();
        String searchType = request.getParameter("searchType");
        if ( searchType == null ) {
            searchType = "ALL";
        }
        paramMap.put("searcyType", searchType);

        ModelAndView mav = new ModelAndView("relknowledge/relknowledge", paramMap);
        return mav;
    }
    
    
    @RequestMapping(value = "/relknowledgeCsvFileUpload.do")
    @ResponseBody
    public ModelAndView relknowledgeCsvFileUpload(
    		HttpServletRequest request,
    		@RequestParam("ex_filename") MultipartFile uploadfile
    		) throws Exception
    {
    	//목표 : 엑셀 파일을 JSON String으로 리턴
    	byte[] readByte = null;
    	String readString = "";
    	
    	readByte = uploadfile.getBytes();
    	
		int byteSize = readByte.length;
		int viewSize = 0;
    	System.out.println("#readByte::"+readByte);
    	System.out.println("#byteSize::"+byteSize);
    	
    	readString = new String(readByte,"UTF-8");	//인코딩 맞춰야
    	System.out.println("#readString::"+readString);
    	
    	//to Json String {word: "키워드", target_type: "WHEN", target_word: "키워드", action: "add"}
    	String[] arrReadString = readString.split(lineFeed);
    	String strResult = "[";
    	String strMessage = "";
    	String strType = "";
    	int intLine = 0;
    	//int intColSize = 0;
    	
    	for(String line : arrReadString){
    		String[] arrCell = line.split(seperator);
    		
    		//헤더 건너뛰기
    		if(intLine<1) {
    			intLine++;
    			continue;
    		}else {
    			intLine++;
    		}
    		
    		//빈줄 건너뛰기
    		if(line.replaceAll(seperator, "").replaceAll(" ", "").equals("")) {
    			continue;
    		}
    		
    		strResult += "{";
    		for(int intCol=0 ; intCol<arrCell.length ; intCol++) {
    			strResult += "col"+intCol+": \""+arrCell[intCol]+"\", ";
    		}
    		strResult = strResult.substring(0, strResult.length()-2);
    		strResult += "},";
    		
    	}
    	strResult = strResult.substring(0, strResult.length()-1);
    	strResult += "]";
    	
    	System.out.println("#resultString::"+strResult.substring(0, 1000) + " 이하생략");
    	System.out.println("#resultString.length::"+strResult.length());
    	System.out.println("총라인수 = " + intLine);
    	
		ModelAndView mav = new ModelAndView("jsonView");
		mav.addObject("strResult", strResult);
		mav.addObject("strMessage", strMessage);
		mav.addObject("strType", strType);
		System.out.println("♨♨♨♨♨♨♨♨    리턴합니다");

		//디버그로 하면 자바소스 디버깅은 되지만 jsp로 리턴이 안됨.
		
		return mav;
    }

    	
}
