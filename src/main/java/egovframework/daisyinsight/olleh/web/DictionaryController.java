package egovframework.daisyinsight.olleh.web;

import egovframework.daisyinsight.common.base.CommonController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by kth on 2017-12-13.
 */
@Controller
public class DictionaryController extends CommonController {

    final String seperator = "\t";
    final String lineFeed = System.getProperty("line.separator");
    
    @RequestMapping(value = "/dictionary.do")
    public ModelAndView biWebMain(HttpServletRequest request ) throws Exception
    {
        logger.debug( "## dictionary " ) ;
        ModelAndView mav = new ModelAndView("dictionary/dictionary");
        return mav;
    }
    
    //CSV 업로드
    @RequestMapping(value = "/dictionaryCsvFileUpload.do")	//@PostMapping("/api/read")
    @ResponseBody
    public ModelAndView dictionaryCsvFileUpload(
    		HttpServletRequest request,
    		@RequestParam("fileCsv") MultipartFile uploadfile
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
    	for(String line : arrReadString){
    		String[] arrCell = line.split(seperator);
    		
    		if(arrCell[0].equals("Type")){
    			continue;
    		}
    		if(strType.equals("")) {
    			strType = arrCell[0];
    		}else if(!strType.equals(arrCell[0])){
    			strMessage = "한파일 2타입";
    			
    			ModelAndView mav = new ModelAndView("jsonView");
    			mav.addObject("strResult", strResult);
    			mav.addObject("strMessage", strMessage);
    			return mav;
    		}
			strResult +=
				"{"+
					"word: \""+arrCell[1]+"\", "+
					"target_type: \""+arrCell[0]+"\", "+
					"target_word: \""+arrCell[1]+"\", "+
					"action: \"add\""+
				"},";
    	}
    	strResult = strResult.substring(0, strResult.length()-1);
    	strResult += "]";
    	
    	System.out.println("#resultString::"+strResult);
    	
		ModelAndView mav = new ModelAndView("jsonView");
		mav.addObject("strResult", strResult);
		mav.addObject("strMessage", strMessage);
		mav.addObject("strType", strType);
		return mav;
    }
    
}
