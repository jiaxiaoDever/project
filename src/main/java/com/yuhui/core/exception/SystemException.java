package com.yuhui.core.exception;
/**
 * 
* @ClassName: SystemException 
* @Description:  系统异常
* @author xiexiaozhi 
* @date 2013-9-27 下午2:10:15 
*
 */
public class SystemException extends RuntimeException {

	private static final long serialVersionUID = 1L;

	public SystemException() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @param message
	 */
	public SystemException(String message) {
		super(message);
		// TODO Auto-generated constructor stub
	}

	/**
	 * @param cause
	 */
	public SystemException(Throwable cause) {
		super(cause);
		// TODO Auto-generated constructor stub
	}

	/**
	 * @param message
	 * @param cause
	 */
	public SystemException(String message, Throwable cause) {
		super(message, cause);
		// TODO Auto-generated constructor stub
	}

}
