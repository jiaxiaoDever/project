package com.yuhui.core.utils;

import java.util.Locale;
import java.util.Map;

import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;

public class SpringContextUtils implements ApplicationContextAware {

	private static ApplicationContext applicationContext; // Spring应用上下文环境

	/**
	 * 实现ApplicationContextAware接口的回调方法，设置上下文环境
	 * 
	 * @param applicationContext
	 * @throws BeansException
	 */
	@Override
	public void setApplicationContext(ApplicationContext applicationContext) throws BeansException {
		SpringContextUtils.applicationContext = applicationContext;
	}

	/**
	 * @return ApplicationContext
	 */
	public static ApplicationContext getApplicationContext() {
		return applicationContext;
	}

	public static boolean containsBean(String beanName) {
		return applicationContext.containsBean(beanName);
	}

	/**
	 * 获取对象
	 * 
	 * @param name
	 * @return Object 一个以所给名字注册的bean的实例
	 * @throws BeansException
	 */
	@SuppressWarnings("unchecked")
	public static <T> T getBean(String name) throws BeansException {
		
		return (T) applicationContext.getBean(name);
	}


	public static <T> Map<String, T> getBeansOfType(Class<T> cls) {
		return applicationContext.getBeansOfType(cls);
	}
	
	public static String getMessage(String key){
        return applicationContext.getMessage(key, null, Locale.getDefault());
    }
}
