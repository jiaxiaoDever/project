package com.yuhui.core.exception;
/**
 * 
* @ClassName: BusinessException 
* @Description:  业务异常类
* @author xiexiaozhi 
* @date 2013-9-27 下午1:10:17 
*
 */
public class BusinessException extends Exception {

	private static final long serialVersionUID = 1L;

	public BusinessException() {
		// TODO Auto-generated constructor stub
		super();
	}

	public BusinessException(String message) {
		super(message);
		// TODO Auto-generated constructor stub
	}

	public BusinessException(Throwable cause) {
		super(cause);
		// TODO Auto-generated constructor stub
	}

	public BusinessException(String message, Throwable cause) {
		super(message, cause);
		// TODO Auto-generated constructor stub
	}

}
