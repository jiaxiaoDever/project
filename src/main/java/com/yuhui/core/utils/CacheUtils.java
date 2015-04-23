package com.yuhui.core.utils;

import java.util.HashMap;
import java.util.Map;

/**
 * 缓存类
 * 
 * @author zhangy
 * 
 */
public class CacheUtils {
	private static CacheUtils INSTANCE;
	private Map<Object, Object> cacheMap;

	private CacheUtils() {
		init();
	}

	public static CacheUtils getInstance() {
		if (INSTANCE == null) {
			INSTANCE = new CacheUtils();
		}
		return INSTANCE;
	}

	private void init() {
		cacheMap = new HashMap<Object, Object>();
	}

	/**
	 * 清空缓存
	 */
	public static void clear() {
		INSTANCE = null;
	}

	/**
	 * 设定缓存
	 * 
	 * @param key
	 * @param value
	 */
	public static void set(Object key, Object value) {
		getInstance().cacheMap.put(key, value);
	}

	/**
	 * 获取缓存
	 * 
	 * @param <T>
	 * 
	 * @param key
	 * @return
	 */
	public static Object get(Object key) {
		if(getInstance().cacheMap.containsKey(key)){
			return getInstance().cacheMap.get(key);
		}else{
			return null;
		}
	}
	
	/**
	 * 获取缓存
	 * 
	 * @param <T>
	 * 
	 * @param key
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public static <T> T get(Object key, Class<T> clz) {
		return (T) getInstance().cacheMap.get(key);
	}
	
	/**
	 * 是否存在
	 * @param key
	 * @return
	 */
	public static boolean containsKey(Object key){
		return getInstance().cacheMap.containsKey(key);
	}

}
