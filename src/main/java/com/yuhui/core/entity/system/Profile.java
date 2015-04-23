package com.yuhui.core.entity.system;

import java.io.Serializable;

public class Profile implements Serializable{

	/**
	 *
	 */
	private static final long serialVersionUID = 1L;

	/** 姓名 */
	private String name;

	/** 员工性别 */
	private Integer sex;

	/** 固定电话 */
	private String phoneNbr;

	/** 小灵通 */
	private String phsNbr;

	/** 移动电话 */
	private String mobileNbr;

	/** 邮件地址 */
	private String emailAddr;


	private String isReceiveOrder;

	public String getIsReceiveOrder() {
		return isReceiveOrder;
	}

	public void setIsReceiveOrder(String isReceiveOrder) {
		this.isReceiveOrder = isReceiveOrder;
	}

	public Integer getSex() {
		return sex;
	}

	public void setSex(Integer sex) {
		this.sex = sex;
	}

	public String getPhoneNbr() {
		return phoneNbr;
	}

	public void setPhoneNbr(String phoneNbr) {
		this.phoneNbr = phoneNbr;
	}

	public String getPhsNbr() {
		return phsNbr;
	}

	public void setPhsNbr(String phsNbr) {
		this.phsNbr = phsNbr;
	}

	public String getMobileNbr() {
		return mobileNbr;
	}

	public void setMobileNbr(String mobileNbr) {
		this.mobileNbr = mobileNbr;
	}

	public String getEmailAddr() {
		return emailAddr;
	}

	public void setEmailAddr(String emailAddr) {
		this.emailAddr = emailAddr;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
}
