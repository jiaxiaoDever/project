package com.yuhui.core.log;

import java.lang.annotation.Retention;
import java.lang.annotation.ElementType;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;


/**
 * 
* @ClassName: CallPerformanceLog 
* @Description:  性能日志监控注解
* @author xiexiaozhi 
* @date 2013-9-24 上午10:07:23 
*
 */
@Retention(RetentionPolicy.RUNTIME)   
@Target(ElementType.METHOD)
public @interface CallPerformanceLog {
	//方法的描述
	public String desc();

}
