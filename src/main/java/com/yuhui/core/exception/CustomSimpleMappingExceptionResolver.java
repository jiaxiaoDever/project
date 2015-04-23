package com.yuhui.core.exception;


import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.SecurityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.SimpleMappingExceptionResolver;

import com.yuhui.core.security.ShiroUser;

/**
 * 
* @ClassName: CustomSimpleMappingExceptionResolver 
* @Description:  SpringMvc 错误异常处理器
* @author xiexiaozhi 
* @date 2013-9-27 下午1:10:40 
*
 */
public class CustomSimpleMappingExceptionResolver extends SimpleMappingExceptionResolver {

	private static Logger log = LoggerFactory.getLogger(CustomSimpleMappingExceptionResolver.class);
	
	@Override
	protected ModelAndView doResolveException(HttpServletRequest request,
			HttpServletResponse response, Object handler, Exception ex) {
		
		String viewName = determineViewName(ex, request);
		if (viewName != null) {// JSP格式返回
			if (!(request.getHeader("accept").indexOf("application/json") > -1 || (request
					.getHeader("X-Requested-With")!= null && request
					.getHeader("X-Requested-With").indexOf("XMLHttpRequest") > -1))) {
				// 如果不是异步请求
				
				//处理返回返回码
				Integer statusCode = determineStatusCode(request, viewName);
				if (statusCode != null) {
					applyStatusCodeIfPossible(request, response, statusCode);
				}
				if(viewName.equals("error/500") && statusCode == 500){//系统异常
					log.error(ex.getMessage(), ex);//记录异常日志
				}else if(viewName.equals("error/errorpage") && statusCode == 500){//业务异常
					StringBuffer sb = new StringBuffer();
					ShiroUser user = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
					String userId =user==null?"":user.getId();
					String username = user==null?"":user.getUsername();
					sb.append("{");
					sb.append("THREAD_ID:").append(Thread.currentThread().getName()).append(",");
					sb.append("USERID:").append(userId).append(",");
					sb.append("USERNAME:").append(username).append(",");
					sb.append("DESC:").append(ex.getMessage());
					
					sb.append("}");
					
					log.info(sb.toString());
				}
				
				return getModelAndView(viewName, ex, request);
			} else {// JSON格式返回
				try {
					PrintWriter writer = response.getWriter();
					writer.write(ex.getMessage());
					writer.flush();
				} catch (Exception e) {
					//e.printStackTrace();
				}
				return null;

			}	
		} else {
			return null;
		}
	}
}
