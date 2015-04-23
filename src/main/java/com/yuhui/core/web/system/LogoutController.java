package com.yuhui.core.web.system;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.yuhui.core.utils.SpringContextUtils;
import com.yuhui.core.utils.SystemInfo;
/**
 * 
* @ClassName: LogoutController 
* @Description:  注销登录
* @author xiexiaozhi 
* @date 2013-11-6 下午3:21:16 
*
 */
@Controller
@RequestMapping(value="/logout")
public class LogoutController {

	@RequestMapping("")
	public void logout(HttpServletRequest request,HttpServletResponse response) {
		System.out.println("logout========================");
		
		Subject subject = SecurityUtils.getSubject();
		
		//消除客户端
		subject.logout();
		//清除会话
		request.getSession().invalidate();
		
		//cas服务端进行logout
		SystemInfo si =(SystemInfo)SpringContextUtils.getBean("sysinfo");
		//String url = si.getCasUrl()+"?service="+si.getClientServiceUrl();
		
		PrintWriter out;
		try {
			out = response.getWriter();
			
			out.print("{" +
					"casUrl:'"+si.getCasUrl()+"',"+
					"clientServiceUrl:'"+si.getClientServiceUrl()+"'"+
				"}");
			out.close();
		} catch (IOException e) {
			
			e.printStackTrace();
		}
		
//		try {
//			response.sendRedirect(url);
//		} catch (IOException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
		
		//System.out.println(SecurityUtils.getSubject().getSession()==null);
		//System.out.println(SecurityUtils.getSubject().getPrincipal());
		//return "index";
	}
}
