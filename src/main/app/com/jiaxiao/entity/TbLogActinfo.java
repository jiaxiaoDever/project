package com.jiaxiao.entity;

import java.io.Serializable;
import javax.persistence.*;
import java.util.Date;


/**
 * @author 肖长江
 * 
 */
@Entity
@Table(name="tb_log_actinfo")
public class TbLogActinfo implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="ACTINFO_ID")
	private String actinfoId;

	private String common;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="LOG_DATE")
	private Date logDate;

	@Column(name="LOG_TIME")
	private Integer logTime;

	@Column(name="OPEN_ID")
	private String openId;

	@Column(name="OPEN_ZH")
	private String openZh;

	@Column(name="OPT_MODUL")
	private String optModul;

	@Column(name="OPT_MODUL_CODE")
	private String optModulCode;

	@Column(name="OPT_TYPE")
	private String optType;

	@Column(name="OPT_TYPE_CODE")
	private String optTypeCode;

	@Column(name="OPT_URL")
	private String optUrl;

	@Column(name="PUBLIC_ID")
	private String publicId;

	@Column(name="PUBLIC_NAME")
	private String publicName;

	@Column(name="REQUEST_PARAM")
	private String requestParam;

	@Column(name="USER_ID")
	private String userId;

	public TbLogActinfo() {
	}

	public String getActinfoId() {
		return this.actinfoId;
	}

	public void setActinfoId(String actinfoId) {
		this.actinfoId = actinfoId;
	}

	public String getCommon() {
		return this.common;
	}

	public void setCommon(String common) {
		this.common = common;
	}

	public Date getLogDate() {
		return this.logDate;
	}

	public void setLogDate(Date logDate) {
		this.logDate = logDate;
	}

	public Integer getLogTime() {
		return this.logTime;
	}

	public void setLogTime(Integer logTime) {
		this.logTime = logTime;
	}

	public String getOpenId() {
		return this.openId;
	}

	public void setOpenId(String openId) {
		this.openId = openId;
	}

	public String getOpenZh() {
		return this.openZh;
	}

	public void setOpenZh(String openZh) {
		this.openZh = openZh;
	}

	public String getOptModul() {
		return this.optModul;
	}

	public void setOptModul(String optModul) {
		this.optModul = optModul;
	}

	public String getOptModulCode() {
		return this.optModulCode;
	}

	public void setOptModulCode(String optModulCode) {
		this.optModulCode = optModulCode;
	}

	public String getOptType() {
		return this.optType;
	}

	public void setOptType(String optType) {
		this.optType = optType;
	}

	public String getOptTypeCode() {
		return this.optTypeCode;
	}

	public void setOptTypeCode(String optTypeCode) {
		this.optTypeCode = optTypeCode;
	}

	public String getOptUrl() {
		return this.optUrl;
	}

	public void setOptUrl(String optUrl) {
		this.optUrl = optUrl;
	}

	public String getPublicId() {
		return this.publicId;
	}

	public void setPublicId(String publicId) {
		this.publicId = publicId;
	}

	public String getPublicName() {
		return this.publicName;
	}

	public void setPublicName(String publicName) {
		this.publicName = publicName;
	}

	public String getRequestParam() {
		return this.requestParam;
	}

	public void setRequestParam(String requestParam) {
		this.requestParam = requestParam;
	}

	public String getUserId() {
		return this.userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

}