package com.yuhui.core.repository.mybatis;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * 通用查询的排序
 * 
 * @author zhangy
 * 
 */
@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.TYPE)
public @interface OrderBy {
	/**
	 * 通用查询的排序
	 * 
	 * @return
	 */
	String value() default "";
}
