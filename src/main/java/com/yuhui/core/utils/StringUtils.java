package com.yuhui.core.utils;

import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.beanutils.PropertyUtils;
import org.springframework.util.CollectionUtils;

public class StringUtils {
	/**
	 * 驼峰命名，默认下划线隔开
	 * 
	 * @param s
	 * @return
	 */
	public static String camelCase(String s) {
		return camelCase(s, '_');
	}

	/**
	 * 驼峰命名
	 * 
	 * @param s
	 * @param space
	 * @return
	 */
	public static String camelCase(String s, char space) {
		String[] words = s.split("" + space);
		StringBuilder returnValue = new StringBuilder(words[0]);
		for (int i = 1; i < words.length; i++) {
			if (words[i].length() >= 1)
				returnValue.append(words[i].substring(0, 1).toUpperCase());
			if (words[i].length() >= 2)
				returnValue.append(words[i].substring(1));
		}
		return returnValue.toString();
	}

	/**
	 * Reverts a string from camel case, using '_' as the word separator.
	 * 
	 * @param s
	 *            The string to be transformed.
	 * @return The new string.
	 */
	public static String unCamelCase(String s) {
		return unCamelCase(s, '_');
	}

	/**
	 * 反驼峰命名
	 * 
	 * @param s
	 * @param space
	 * @return
	 */
	public static String unCamelCase(String s, char space) {
		final Pattern pattern = Pattern.compile("([a-z0-9])([A-Z])");
		Matcher matcher = pattern.matcher(s);
		while (matcher.find()) {
			s = matcher.replaceFirst(matcher.group(1) + space + matcher.group(2).toLowerCase());
			matcher.reset(s);
		}
		return s;
	}

	/**
	 * 把list用分隔符转成字符串
	 * 
	 * @param ls
	 *            来源List
	 * @return
	 */
	public static <T> String list2Str(List<T> ls) {
		return list2Str(ls, ",", null);
	}

	/**
	 * 把list用分隔符转成字符串
	 * 
	 * @param ls
	 *            来源List
	 * @return
	 */
	public static <T> String list2Str(List<T> ls, String key) {
		return list2Str(ls, ",", key);
	}

	/**
	 * 把list用分隔符转成字符串
	 * 
	 * @param ls
	 *            来源List
	 * @param separator
	 *            分隔符
	 * @param key
	 *            属性名称
	 * @return
	 */
	public static <T> String list2Str(List<T> ls, String separator, String key) {
		if (CollectionUtils.isEmpty(ls))
			return null;
		StringBuffer sb = new StringBuffer();
		Object value = null;
		try {
			for (T t : ls) {
				sb.append(separator);
				if (null != key) {
					value = PropertyUtils.getProperty(t, key);
					if (value.getClass().equals(String.class)) {
						value = "\'" + value + "\'";
					}
					sb.append(value);
				} else {
					sb.append(t);
				}
			}
			return sb.substring(1);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

}
