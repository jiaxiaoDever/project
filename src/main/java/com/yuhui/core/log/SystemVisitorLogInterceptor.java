package com.yuhui.core.log;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.net.InetAddress;
import java.net.URISyntaxException;
import java.net.UnknownHostException;
import java.util.Properties;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.SecurityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter; 

import com.yuhui.core.security.ShiroUser;
import com.yuhui.core.utils.UUID;

/**
 * 
* @ClassName: SystemVisitorLogInterceptor 
* @Description:  系统访问路径拦截器
* @author xiexiaozhi 
* @date 2013-9-27 上午9:15:44 
*
 */
@Repository
public class SystemVisitorLogInterceptor extends HandlerInterceptorAdapter {
	
		private static Logger log = LoggerFactory.getLogger(SystemVisitorLogInterceptor.class);
		
		private static String regx =getRegx();
		
		
		
	 	/**
	 	 * url过滤拦截日志
	 	 */
	    @Override  
	    public boolean preHandle(HttpServletRequest request,  
	            HttpServletResponse response, Object handler) throws Exception {
	 			//request.setCharacterEncoding("UTF-8");  
	 			//response.setCharacterEncoding("UTF-8");
	 			String uri = request.getRequestURI();
	 			log.info("\rtrequest url:" + request.getRequestURL() + "	queryString:"+request.getQueryString());
	 			//判断url是否带参数?
	 			boolean find = false ;
	 			if(uri.indexOf("?")!=-1){
	 				Pattern p = Pattern.compile("(.+)\\?");
	 		        Matcher m = p.matcher(uri);
	 		        while (m.find()) {
	 		        	find = checkUrl(m.group());  
	 		        	break;
	 		        	
	 		        } 
	 			}else{
	 				find = checkUrl(uri);
	 			}
	 			if(find){//属于静态的url.如css ，js等
	 				ShiroUser user = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
		 			if(user != null ){//已经登录
		 				String ip = request.getRemoteAddr();
		 				
		 				String userId = user.getId();
		 				String sessionId =request.getSession().getId();
		 				Thread.currentThread().setName(UUID.Gen_UUID());
		 				StringBuffer sb = new StringBuffer();
		 				sb.append("{");
		 				sb.append("HOST:").append(getIpAddress()).append(",");
		 				sb.append("URL:").append(uri).append(",");
		 				sb.append("USERIP:").append(ip).append(",");
		 				sb.append("USERID:").append(userId).append(",");
		 				sb.append("USERNAME:").append(user.getUsername()).append(",");
		 				sb.append("SESSIONID:").append(sessionId).append(",");
		 				sb.append("THREAD_ID:").append(Thread.currentThread().getName());
		 				sb.append("}");
		 				log.info(sb.toString());
		 				
		 			}
	 			}
	 			
	 			return super.preHandle(request, response, handler);
		 
	 }
	 	/**
	 	 * 
	 	* @Title: checkUrl 
	 	* @Description: 过滤掉的不需要记录类型路径 
	 	* @param @param url
	 	* @return boolean    返回类型 
	 	* @throws
	 	 */
	 	private boolean checkUrl(String url){
			//Pattern pattern = Pattern.compile("jsp|asp|aspx|php|html|htm|action|servlet|do");
	 		if(regx == null||"".equals(regx)){
	 			regx= "js|css|jpg|jpeg|gif|png|swf|app";
	 		}
			Pattern pattern = Pattern.compile("\\.("+regx+")");
			Matcher matcher = pattern.matcher(url);
			if(matcher.find()){
				return false;
			}
			return true;
	 	}
	 	
	 	private static String getIpAddress()  {  
	        InetAddress address;
	        String add ="";
			try {
				address = InetAddress.getLocalHost();
				add = address.getHostAddress();
			} catch (UnknownHostException e) {
				e.printStackTrace();
			}  
	  
	        return add;  
	    }
	 	
	 	private static String getRegx() {
	 		String reg ="";
	 		InputStream in = null;
			try {
				String s =SystemVisitorLogInterceptor.class.getResource("/").toURI().getPath()+"application.properties";
				System.out.println("=====================application.properties:"+s);
				Properties prop = new Properties();
				in =  new FileInputStream(s);
				prop.load(in);
				reg = prop.getProperty("no_log_url_regx");
				 
				
			} catch (FileNotFoundException e) {
				//e.printStackTrace();
			} catch (IOException e) {
				//e.printStackTrace();
			} catch (URISyntaxException e) {
				//e.printStackTrace();
			}finally{
				try {
					if(in!=null)
					in.close();
				} catch (IOException e) {
					
				}
			}
			if(reg==null ||"".equals(reg)){
				reg="js|css|jpg|jpeg|gif|png|swf|app";
			}
			
			return reg ;
	 	}
}
