package com.yuhui.core.log;

import java.lang.reflect.Method;
import java.net.InetAddress;
import java.net.UnknownHostException;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.time.StopWatch;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Pointcut;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.aop.ThrowsAdvice;
import org.springframework.stereotype.Component;
/**
 * 
* @ClassName: AspectLogMethod 
* @Description:  拦截用户线程堆栈上的执行方法情况
* @author xiexiaozhi 
* @date 2013-9-24 下午5:59:35 
*
 */
@Aspect  
@Component 
public class AspectLogMethod implements ThrowsAdvice{

	private static Logger log = LoggerFactory.getLogger(AspectLogMethod.class);
	private static final String host = getIpAddress();
	
	/**
	 * 
	* @Title: doWeb 
	* @Description: 控制器检查点 
	* @param     设定文件 
	* @return void    返回类型 
	* @throws
	 */
	@Pointcut("execution(* com.yuhui.core.web..*(..))")
	public void doWeb() {

	}
	
	/**
	 * 
	* @Title: doService 
	* @Description: 服务层检查点 
	* @param     设定文件 
	* @return void    返回类型 
	* @throws
	 */
	@Pointcut("execution(* com.yuhui.core.service..*(..))")
	public void doService() {

	}
	
	/**
	 * 
	* @Title: doAround 
	* @Description: 拦截方环绕 
	* @param @param joinPoint
	* @param @return
	* @param @throws Throwable    设定文件 
	* @return Object    返回类型 
	* @throws
	 */
	@Around("doWeb() || doService() ") 
	public Object doAround(ProceedingJoinPoint joinPoint) throws Throwable{
				//判断方法是否有监控的注解
				Method mth = getMethod(joinPoint.getTarget().getClass(),joinPoint.getSignature().getName());
				
				//发起调用监控的注解
				CallPerformanceLog cpl = mth.getAnnotation(CallPerformanceLog.class);
				
				String desc = "" ;
				if(cpl != null){
					//没有注解，则不进行日志记录
					//return joinPoint.proceed();
					desc = cpl.desc();//现在只作为描述方法
				}
				
				StopWatch clock = new StopWatch();  
				
		        clock.start(); //计时开始  
		        Object result = joinPoint.proceed(); //执行方法 
		        clock.stop();  //计时结束  
		        
		     // 方法参数类型，转换成简单类型
//				Class[] params = mth.getParameterTypes();
//				String[] simpleParams = new String[params.length];
//				for (int i = 0; i < params.length; i++) {
//					simpleParams[i] = params[i].getSimpleName();
//				}
				Object[] args = joinPoint.getArgs();
				StringBuffer sb = new StringBuffer();
				sb.append("{");
				sb.append("HOST:").append(host).append(",");
				sb.append("THREAD_ID:").append(Thread.currentThread().getName()).append(",");
				sb.append("CLASS:").append(joinPoint.getTarget().getClass()).append(",");
				sb.append("METHOD:").append(joinPoint.getSignature().getName()).append(",");
				sb.append("ARGS:").append(StringUtils.join(args, "|")).append(",");
				sb.append("TAKES:").append(clock.getTime()).append("ms").append(",");
				sb.append("DESC:").append(desc);
				sb.append("}");

				log.info(sb.toString());
				return result;
		
	}
	/**
	 * 
	* @Title: getMethod 
	* @Description: 获取方法对象 
	* @param @param clazz
	* @param @param methodName
	* @param @return    设定文件 
	* @return Method    返回类型 
	* @throws
	 */
	@SuppressWarnings("rawtypes")
	public static Method getMethod(Class clazz,String methodName) {  
        Method[] methods = clazz.getMethods();  
        Method m = null ;
        for(Method method : methods){  
            if(methodName.equals(method.getName())){  
            	m= method;
                break ;
            }  
        }
		return m;  
         
    }
	/**
	 * 
	* @Title: getIpAddress 
	* @Description: 获取本机IP
	* @param @return    设定文件 
	* @return String    返回类型 
	* @throws
	 */
	public static String getIpAddress()  {  
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
}
