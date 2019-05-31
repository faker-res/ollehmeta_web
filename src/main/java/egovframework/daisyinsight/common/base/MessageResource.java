package egovframework.daisyinsight.common.base;

import org.springframework.context.MessageSource;
import org.springframework.context.MessageSourceAware;

import java.util.Locale;


/**
 * @author kth
 *
 */
public class MessageResource implements MessageSourceAware {
	
	private static MessageSource msa;
    
    public void setMessageSource(MessageSource msa){
          MessageResource.msa = msa;
    }
    
	public static String msg(String key){
    	return msa.getMessage(key, null, Locale.getDefault());
	}
}
