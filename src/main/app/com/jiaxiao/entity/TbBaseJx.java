package com.jiaxiao.entity;

import java.io.Serializable;
import javax.persistence.*;
import java.util.Date;


/**
 * @author 肖长江
 * 驾校基础信息
 */
@Entity
@Table(name="tb_base_jx")
public class TbBaseJx implements Serializable {
	private static final long serialVersionUID = 1L;

	/** 驾校编号*/
	@Id
	@Column(name="JX_ID")
	private String jxId;

	/** 驾校备注*/
	private String common;

	/** 创建时间*/
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="CREATE_DATE")
	private Date createDate;

	/** 编辑时间*/
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="EDIT_DATE")
	private Date editDate;

	/** 驾校地址*/
	@Column(name="JX_ADDRESS")
	private String jxAddress;

	/** 驾校简介*/
	@Column(name="JX_INFO")
	private String jxInfo;

	/** 驾校LOGO图片地址*/
	@Column(name="JX_LOGO")
	private String jxLogo;

	/** 驾校名称*/
	@Column(name="JX_NAME")
	private String jxName;

	/** 驾校联系电话*/
	@Column(name="JX_PHONE")
	private String jxPhone;

	/** 客服QQ*/
	@Column(name="JX_QQ")
	private String jxQq;

	/** 驾校简写名称*/
	@Column(name="JX_SHORT_NAME")
	private String jxShortName;

	/** 驾校状态*/
	@Column(name="JX_STAT")
	private String jxStat;

	/** 驾校状态编码*/
	@Column(name="JX_STAT_CODE")
	private String jxStatCode;

	/** 驾校联系人手机号*/
	@Column(name="JX_TEL")
	private String jxTel;

	public TbBaseJx() {
	}

	public String getJxId() {
		return this.jxId;
	}

	public void setJxId(String jxId) {
		this.jxId = jxId;
	}

	public String getCommon() {
		return this.common;
	}

	public void setCommon(String common) {
		this.common = common;
	}

	public Date getCreateDate() {
		return this.createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public Date getEditDate() {
		return this.editDate;
	}

	public void setEditDate(Date editDate) {
		this.editDate = editDate;
	}

	public String getJxAddress() {
		return this.jxAddress;
	}

	public void setJxAddress(String jxAddress) {
		this.jxAddress = jxAddress;
	}

	public String getJxInfo() {
		return this.jxInfo;
	}

	public void setJxInfo(String jxInfo) {
		this.jxInfo = jxInfo;
	}

	public String getJxLogo() {
		return this.jxLogo;
	}

	public void setJxLogo(String jxLogo) {
		this.jxLogo = jxLogo;
	}

	public String getJxName() {
		return this.jxName;
	}

	public void setJxName(String jxName) {
		this.jxName = jxName;
	}

	public String getJxPhone() {
		return this.jxPhone;
	}

	public void setJxPhone(String jxPhone) {
		this.jxPhone = jxPhone;
	}

	public String getJxQq() {
		return this.jxQq;
	}

	public void setJxQq(String jxQq) {
		this.jxQq = jxQq;
	}

	public String getJxShortName() {
		return this.jxShortName;
	}

	public void setJxShortName(String jxShortName) {
		this.jxShortName = jxShortName;
	}

	public String getJxStat() {
		return this.jxStat;
	}

	public void setJxStat(String jxStat) {
		this.jxStat = jxStat;
	}

	public String getJxStatCode() {
		return this.jxStatCode;
	}

	public void setJxStatCode(String jxStatCode) {
		this.jxStatCode = jxStatCode;
	}

	public String getJxTel() {
		return this.jxTel;
	}

	public void setJxTel(String jxTel) {
		this.jxTel = jxTel;
	}

}