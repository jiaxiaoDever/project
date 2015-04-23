package com.yuhui.core.utils;

import java.io.IOException;
import java.util.Properties;

public class ConfigUtils {
	private static final  Properties p;
	static{
		p = new Properties();
		try {
			p.load(ConfigUtils.class.getClassLoader().getResourceAsStream("config.properties")) ;
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	public static String get(String key){
		return p.getProperty(key);
	}
}
