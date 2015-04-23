package com.yuhui.core.utils.json;

import java.util.LinkedHashMap;

import org.codehaus.jackson.annotate.JsonAutoDetect;





/**
 * 
 * @author 
 *
 */
@JsonAutoDetect
public class JsonResult extends LinkedHashMap<String, Object> {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1996236077530848486L;
	private final static String KEY_SUCCESS = "success";
	private final static String KEY_MESSAGE = "msg";

	public static JsonResult create() {
		JsonResult result = new JsonResult();
		result.setSuccess(true);
		return result;
	}
	
	public static JsonResult create(boolean success,String msg) {
		JsonResult result = new JsonResult();
		result.setSuccess(success);
		result.setMsg(msg);
		return result;
	}

	public boolean isSuccess() {
		return Boolean.TRUE.equals(get(KEY_SUCCESS));
	}

	public void setSuccess(boolean success) {
		put(KEY_SUCCESS, success);
	}

	public JsonResult success(boolean success) {
		setSuccess(success);
		return this;
	}

	public String getMsg() {
		return (String)this.get(KEY_MESSAGE);		
	}

	public void setMsg(String msg) {
		put(KEY_MESSAGE, msg);
	}

	public JsonResult msg(String msg) {
		setMsg(msg);
		return this;
	}
	
	public JsonResult put(String key,Object value) {
		super.put(key, value);
		return this;
	}

	public JsonResult msgf(String format, Object... args) {
		setMsg(String.format(format, args));
		return this;
	}

}
