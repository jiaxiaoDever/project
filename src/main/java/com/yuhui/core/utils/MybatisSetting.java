package com.yuhui.core.utils;

public class MybatisSetting {

	public void setLog(){
		org.apache.ibatis.logging.LogFactory.useSlf4jLogging(); 
	}
}
