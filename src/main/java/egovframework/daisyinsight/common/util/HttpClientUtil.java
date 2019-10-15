package egovframework.daisyinsight.common.util;

import org.apache.commons.httpclient.HttpConnectionManager;
import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.httpclient.SimpleHttpConnectionManager;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.httpclient.params.HttpConnectionManagerParams;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.HttpClient;
import org.apache.http.client.ResponseHandler;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.utils.URIBuilder;
import org.apache.http.impl.client.*;
import org.apache.http.message.BasicNameValuePair;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URI;
import java.util.*;

/**
 * Created by kth on 2018-01-08.
 */
@Component
public class HttpClientUtil {
    private static final Logger logger = LoggerFactory.getLogger(HttpClientUtil.class);

    @Autowired
    private OllehHttpClientUtil ollehHttpClientUtil;

    @Value("#{config['olleh.meta.url']}")
    private String apiUrl;

    private String USER_AGENT = "Mozilla/5.0";

    public String getApiUrl() {
        return apiUrl;
    }


    public String requestOllehMeta(HashMap<String,Object> apiInfoMap, HashMap<String,Object> apiParamMap) throws Exception {

    	System.out.println("[저장시 메타키워드 누락 테스트] - HttpClientUtil.requestOllehMeta");
    	
        String path = (String) apiInfoMap.get("url");
        String method = (String) apiInfoMap.get("method");

        System.out.println("[저장시 메타키워드 누락 테스트] - HttpClientUtil.requestOllehMeta - path - " + path);
        System.out.println("[저장시 메타키워드 누락 테스트] - HttpClientUtil.requestOllehMeta - method - " + method);
        
        //로컬서버(개발PC) 테스트
        //apiUrl = "http://127.0.0.1:8080";
        
        if ( "GET".equalsIgnoreCase(method) ) {
            // GET
            String param = formatQueryParams(apiParamMap);
            System.out.println("[저장시 메타키워드 누락 테스트] - HttpClientUtil.requestOllehMeta - (method=get) cmts에 보내기 전");
            System.out.println("[저장시 메타키워드 누락 테스트] - HttpClientUtil.requestOllehMeta - param - " + param);
            return sendGet(path, param);
        } else {
            System.out.println("[저장시 메타키워드 누락 테스트] - HttpClientUtil.requestOllehMeta - path - " + path);
            System.out.println("[저장시 메타키워드 누락 테스트] - HttpClientUtil.requestOllehMeta - method - " + method);
            // POST
            //return sendPost(path, apiParamMap);
            //return ollehHttpClientUtil.reqPost(apiUrl + path, apiParamMap);
            //return Post(path, apiParamMap);
            System.out.println("[저장시 메타키워드 누락 테스트] - HttpClientUtil.requestOllehMeta - (method=post) cmts에 보내기 전");
            System.out.println("[저장시 메타키워드 누락 테스트] - HttpClientUtil.requestOllehMeta - apiParamMaptoString() - " + apiParamMap.toString());
            return postTest(apiUrl + path, apiParamMap);
        }
    }

    public String sendGet(String path, String param) throws Exception {
        System.out.println("[저장시 메타키워드 누락 테스트] - HttpClientUtil.sendGet");

        String url = apiUrl + path+ param;

        HttpClient client = new DefaultHttpClient();
        HttpGet request = new HttpGet(url);

        // add request header
        request.addHeader("content-type", "application/json; charset=utf-8");
        request.addHeader("accept", "application/json; charset=utf-8");

        HttpResponse response = client.execute(request);

        System.out.println("\nSending 'GET' request to URL : " + url);
        System.out.println("Response Code : " +
                response.getStatusLine().getStatusCode());

        BufferedReader rd = new BufferedReader(
                new InputStreamReader(response.getEntity().getContent(), "UTF-8"));

        StringBuffer result = new StringBuffer();
        String line = "";
        while ((line = rd.readLine()) != null) {
            result.append(line);
        }
        System.out.println("Response Msg : " + result.toString());
        System.out.println("[저장시 메타키워드 누락 테스트] - HttpClientUtil.sendGet return");
        return result.toString();

    }

    public String get(String url) throws Exception {

        HttpClient client = new DefaultHttpClient();
        HttpGet request = new HttpGet(url);

        // add request header
        request.addHeader("content-type", "application/json; charset=utf-8");
        request.addHeader("accept", "application/json; charset=utf-8");

        HttpResponse response = client.execute(request);

        System.out.println("\nSending 'GET' request to URL : " + url);
        System.out.println("Response Code : " +
                response.getStatusLine().getStatusCode());

        BufferedReader rd = new BufferedReader(
                new InputStreamReader(response.getEntity().getContent(), "UTF-8"));

        StringBuffer result = new StringBuffer();
        String line = "";
        while ((line = rd.readLine()) != null) {
            result.append(line);
        }
        System.out.println("Response Msg : " + result.toString());
        return result.toString();
    }

    /*
    // HTTP POST request
        public String sendPost(String path, HashMap<String, Object> apiParam) throws Exception {

        //String url = apiUrl + path;

            CloseableHttpClient client = HttpClients.createDefault();

        // add header
        List<NameValuePair> urlParameters = new ArrayList<NameValuePair>();

        URIBuilder uriBuilder = new URIBuilder();
        uriBuilder.setScheme("http").setHost("14.63.170.72").setPort(8080).setPath(path);
        URI uri = uriBuilder.build();

        for( String key : apiParam.keySet() ){
            urlParameters.add(new BasicNameValuePair(key, (String) apiParam.get(key)));
            uriBuilder.addParameter(key, (String) apiParam.get(key));
        }

        //post.setEntity(new UrlEncodedFormEntity(urlParameters));
        System.out.println("\nSending 'POST' request to URL : " + "");
        //System.out.println("Post parameters : " + post.getEntity());

        HttpPost post = new HttpPost(uri);

//        post.setHeader("content-type", "application/json; charset=utf-8");
//        post.setHeader("accept", "application/json; charset=utf-8");

        CloseableHttpResponse response = client.execute(post);

        System.out.println("Response Code : " +
                response.getStatusLine().getStatusCode());


        BufferedReader rd = new BufferedReader(
                new InputStreamReader(response.getEntity().getContent(), "UTF-8"));

        StringBuffer result = new StringBuffer ();
        String line = "";
        while ((line = rd.readLine()) != null) {
            result.append(line);
        }
        System.out.println("Response Msg : " + result.toString());

        return result.toString();
    }
    */

    private List<NameValuePair> convertParam(Map params){
        List<NameValuePair> paramList = new ArrayList<NameValuePair>();
        Iterator<String> keys = params.keySet().iterator();
        while(keys.hasNext()){
            String key = keys.next();
            paramList.add(new BasicNameValuePair(key, params.get(key).toString()));
        }

        return paramList;
    }

    /**
     * POST 요청
     * @param url       요청할 url
     * @param params    파라메터
     * @param encoding  파라메터 Encoding
     * @return 서버 응답결과 문자열
     */
    public String postTest(String url, HashMap<String,Object> params, String encoding){
        System.out.println("[저장시 메타키워드 누락 테스트] - HttpClientUtil.postTest");
        HttpClient client = new DefaultHttpClient();

        try{
            HttpPost post = new HttpPost(url);
            System.out.println("\nSending 'POST' request to URL : " + post.getURI());

            List<NameValuePair> paramList = convertParam(params);
            System.out.println("[저장시 메타키워드 누락 테스트] - HttpClientUtil.postTest - paramList = " + paramList.toString());
            post.setEntity(new UrlEncodedFormEntity(paramList, encoding));

            ResponseHandler<String> rh = new BasicResponseHandler();

            System.out.println("[저장시 메타키워드 누락 테스트] - HttpClientUtil.postTest - rh = " + rh.toString());
            
            System.out.println("[저장시 메타키워드 누락 테스트] - HttpClientUtil.postTest - client.execute(post, rh) 실행 전");
            String result =  client.execute(post, rh);
            System.out.println("[저장시 메타키워드 누락 테스트] - HttpClientUtil.postTest - client.execute(post, rh) 실행 후");
            System.out.println("Response Msg : " + result);

            System.out.println("[저장시 메타키워드 누락 테스트] - HttpClientUtil.postTest - HttpClientUtil.postTest return 직전");
            return result;
        }catch(Exception e){
            e.printStackTrace();
            System.out.println(e.toString());
        }finally{
            client.getConnectionManager().shutdown();
        }
        System.out.println("[저장시 메타키워드 누락 테스트] - HttpClientUtil.postTest return - error");
        return "error";
    }

    public String postTest(String url, HashMap<String,Object> params){
        System.out.println("[저장시 메타키워드 누락 테스트] - HttpClientUtil.postTest");
        return postTest(url, params, "UTF-8");
    }


    public String Post(String path, Map<String, Object> paramData) {

        String url = apiUrl + path;
        HttpConnectionManagerParams connectionParams = new HttpConnectionManagerParams();
        connectionParams.setSendBufferSize(2133221331);

        HttpConnectionManager manager = new SimpleHttpConnectionManager();
        manager.setParams(connectionParams);


        org.apache.commons.httpclient.HttpClient client = new org.apache.commons.httpclient.HttpClient(manager);
        PostMethod method = new PostMethod(url);
        String readLine;
        BufferedReader br = null;
        StringBuffer resultStr = new StringBuffer();
        int result = 0;
        try {
            org.apache.commons.httpclient.NameValuePair params[] = null;
            if(paramData != null && paramData.size() > 0) {
                params = new org.apache.commons.httpclient.NameValuePair[paramData.size()];

                int count = 0;
                for(Map.Entry<String, Object> entry : paramData.entrySet()) {
                    params[count] = new org.apache.commons.httpclient.NameValuePair(entry.getKey(), (String)entry.getValue());
                    count++;
                }
            }

            method.addRequestHeader("content-type", "application/x-www-form-urlencoded; charset=utf-8");
            method.setQueryString(params);
//			method.setRequestBody(params);
            //method.addRequestHeader("accept", "application/x-www-form-urlencoded; charset=utf-8");
            int returnCode = client.executeMethod(method);

            if(returnCode == HttpStatus.SC_OK){
                br = new BufferedReader(new InputStreamReader(
                        method.getResponseBodyAsStream(), "UTF-8"));

                while (((readLine = br.readLine()) != null)) {
                    resultStr.append(readLine);
                }
            }else if(returnCode == HttpStatus.SC_NOT_IMPLEMENTED) {
                logger.error("The Post method is not implemented by this URI");
                method.getResponseBodyAsString();
                readLine = String.valueOf(returnCode);
            }else{
                logger.error(url + " : URL connection Faied (HTTP STATUS " + returnCode + ")");
                method.getResponseBodyAsString();
                readLine = String.valueOf(returnCode);
            }
        } catch(Exception e) {
            e.printStackTrace();
            return e.toString();
        }finally {
            method.releaseConnection();
            if (br != null)
                try {
                    br.close();
                } catch (Exception fe) {
                    fe.printStackTrace();
                }
        }
        System.out.println("Response Msg : " + resultStr.toString());
        return resultStr.toString();

    }

    protected String formatQueryParams(HashMap<String, Object> params) {
        return params.entrySet().stream()
                .map(p -> p.getKey() + "=" + p.getValue())
                .reduce((p1, p2) -> p1 + "&" + p2)
                .map(s -> "?" + s)
                .orElse("");
    }
}
