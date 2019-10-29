package egovframework.daisyinsight.olleh.web;

import egovframework.daisyinsight.common.base.CommonController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
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
    		@RequestParam("ex_filename") MultipartFile uploadfile,
    		@RequestParam("type") String strType
    		) throws Exception
    {
    	Calendar calendar = Calendar.getInstance();		//[파일업다운로드]
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");		//[파일업다운로드]
    	
    	
    	//logger.info("[파일업다운로드] " + format.format(new Date()) + " frelknowledgeCsvFileUpload 시작");
    	//목표 : 엑셀 파일을 JSON String으로 리턴
    	byte[] readByte = null;
    	String readString = "";
    	
    	readByte = uploadfile.getBytes();
    	//logger.info("[파일업다운로드] " + format.format(new Date()) + " readByte = uploadfile.getBytes();");
    	
		int byteSize = readByte.length;
		int viewSize = 0;
    	System.out.println("#readByte::"+readByte);
    	System.out.println("#byteSize::"+byteSize);
    	
    	readString = new String(readByte,"UTF-8");	//인코딩 맞춰야
    	//readString = new String(readByte,"euc-kr");	//인코딩 맞춰야
    	System.out.println("#readString::"+readString);
    	
    	//to Json String {word: "키워드", target_type: "WHEN", target_word: "키워드", action: "add"}
    	String[] arrReadString = readString.split(lineFeed);
    	String strResult = "[";
    	String strMessage = "";
    	String strTmpCol = "";
    	//String strType = "";
    	int intLine = 0;
    	int intDatas = 0;
    	//int intColSize = 0;
    	
    	//logger.info("[파일업다운로드] " + format.format(new Date()) + " line 반복문 시작");
    	
    	for(String line : arrReadString){
    		String[] arrCell = line.split(seperator);
    		
    		//헤더 건너뛰기
    		if(intLine<1) {
    			intLine++;
    			continue;
    		}else {
    			intLine++;
    		}
    		//System.out.println("♨♨♨♨    Processing : " + intLine + " / " + arrReadString.length);
    		
    		//빈줄 건너뛰기
    		if(line.replaceAll(seperator, "").replaceAll(" ", "").equals("")) {
    			continue;
    		}
			//System.out.println("line - " + line);
    		
    		
    		//배열 끊을 수 있는 문자 삽입
    		//strResult
    		//intDatas++;//맨아래로
    		if(intDatas%500==0 && intDatas>0) {
    			strResult = strResult.substring(0, strResult.length()-1);
    			strResult += "]:/:/:/:[";
    		}
    		
    		strResult += "{";
    		for(int intCol=0 ; intCol<arrCell.length ; intCol++) {
    			//strResult += "col"+intCol+": \""+arrCell[intCol]+"\", ";
    			//System.out.println(" " + intCol + ":[" + arrCell[intCol] + "]");
    			strTmpCol = arrCell[intCol];
    			
    			//특수기호
    			//strTmpCol.replaceAll("\n", "");
    			//strTmpCol.replaceAll("\r", "");
    			//strTmpCol.replaceAll("\\", "");
    			
    			
    			if(strTmpCol.equals("")) {
    				strResult += "col"+intCol+": \"\", ";
    			}else {
        			//10.07 : "dd,dd" 인 경우 앞 뒤 따옴표 빼고
        			//System.out.println(arrCell[intCol].substring(0, 1));
        			//System.out.println(arrCell[intCol].substring(arrCell[intCol].length()-1, arrCell[intCol].length()));
        			//System.out.println("result - " + "col"+intCol+": "+arrCell[intCol]+",   or   col"+intCol+": \""+arrCell[intCol]+"\", ");
        			if(strTmpCol.substring(0, 1).equals("\"") && strTmpCol.substring(strTmpCol.length()-1, strTmpCol.length()).equals("\"")) {
        				strResult += "col"+intCol+": "+strTmpCol+", ";
        			}else {
        				strResult += "col"+intCol+": \""+strTmpCol+"\", ";
        			}
    			}
    		}
    		strResult = strResult.substring(0, strResult.length()-2);
    		strResult += "},";
    		
    		intDatas++;	//위에서 여기로
    		
    	}
    	//logger.info("[파일업다운로드] " + format.format(new Date()) + " line 반복문 끝");
    	strResult = strResult.substring(0, strResult.length()-1);
    	strResult += "]";
    	
    	System.out.println("#resultString::"+strResult.substring(0, 1000) + " 이하생략");
    	System.out.println("#resultString.length::"+strResult.length());
    	System.out.println("총라인수 = " + intLine);
    	System.out.println("처리 데이터수 = " + intDatas);
    	
		ModelAndView mav = new ModelAndView("jsonView");
		mav.addObject("strResult", strResult);
		mav.addObject("strMessage", strMessage);
		mav.addObject("strType", strType);
		//logger.info("[파일업다운로드] 리턴합니다");

		//디버그로 하면 자바소스 디버깅은 되지만 jsp로 리턴이 안됨.
		
    	//logger.info("[파일업다운로드] " + format.format(new Date()) + " frelknowledgeCsvFileUpload 끝");
		return mav;
    }

    	
}
