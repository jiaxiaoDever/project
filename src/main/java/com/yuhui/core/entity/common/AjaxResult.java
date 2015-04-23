package com.yuhui.core.entity.common;

import java.io.Serializable;

import com.yuhui.core.utils.LocaleUtils;

/**
 * Ajax返回值
 * 
 * @author zhangy
 * 
 */
public class AjaxResult implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 3780029263034183599L;
	/**
	 * 是否成功
	 */
	private boolean success;
	/**
	 * 返回原因类型名称
	 */
	private String title;
	/**
	 * 返回原因内容
	 */
	private String reason;
	/**
	 * 返回结果
	 */
	private Object result;

	public AjaxResult() {
	}

	/**
	 * 
	 * @param success
	 *            是否成功
	 * @param title
	 *            返回原因类型名称
	 * @param reason
	 *            返回原因内容
	 */
	public AjaxResult(boolean success, String title, String reason, Object result) {
		this.success = success;
		this.title = title;
		this.reason = reason;
		this.result = result;
	}

	public AjaxResult(boolean success, String title, String reason) {
		this.success = success;
		this.title = title;
		this.reason = reason;
		this.result = null;
	}

	public boolean isSuccess() {
		return success;
	}

	public void setSuccess(boolean success) {
		this.success = success;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	public static AjaxResult success(String title,Object result) {
		return new AjaxResult(true, title, title, result);
	}
	public static AjaxResult success(Object result) {
		return new AjaxResult(true, null, null, result);
	}

	public static AjaxResult success(String title) {
		return new AjaxResult(true, title, title);
	}

	public static AjaxResult success() {
		return new AjaxResult(true, LocaleUtils.get("ajaxResult.Ok"), LocaleUtils.get("ajaxResult.Ok"));
	}

	public static AjaxResult success(String title, String reason) {
		return new AjaxResult(true, title, reason);
	}
	
	public static AjaxResult failure(String reason) {
		return new AjaxResult(false, LocaleUtils.get("ajaxResult.error"), reason);
	}
	public static AjaxResult failure(String title, String reason) {
		return new AjaxResult(false, title, reason);
	}

	public Object getResult() {
		return result;
	}

	public void setResult(Object result) {
		this.result = result;
	}

}
