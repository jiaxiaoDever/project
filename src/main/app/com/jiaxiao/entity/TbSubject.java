package com.jiaxiao.entity;

import java.io.Serializable;
import javax.persistence.*;
import java.util.Date;


/**
 * @author 肖长江
 * 科目信息
 */
@Entity
@Table(name="tb_subject")
public class TbSubject implements Serializable {
	private static final long serialVersionUID = 1L;

	/** 科目编号*/
	@Id
	@Column(name="SUBJECT_ID")
	private String subjectId;

	/** 备注*/
	private String common;

	/** 创建时间*/
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="CREATE_DATE")
	private Date createDate;

	/** 删除时间*/
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="DELETE_DATE")
	private Date deleteDate;

	/** 是否在考*/
	@Column(name="IS_ON")
	private Integer isOn;

	/** 是否要理论考试*/
	@Column(name="IS_ON_THEORY")
	private Integer isOnTheory;

	/** 是否要路考*/
	@Column(name="IS_ONROAD")
	private Integer isOnroad;

	/** 驾照类型*/
	@Column(name="LICENSE_TYPE")
	private String licenseType;

	/** 驾照类型编码*/
	@Column(name="LICENSE_TYPE_CODE")
	private String licenseTypeCode;

	/** 科目学名*/
	@Column(name="SUBJECT_ASNAME")
	private String subjectAsname;

	/** 科目代码*/
	@Column(name="SUBJECT_CODE")
	private String subjectCode;

	/** 科目级别*/
	@Column(name="SUBJECT_GREATE")
	private Integer subjectGreate;

	/** 科目简介*/
	@Column(name="SUBJECT_INFO")
	private String subjectInfo;

	/** 科目名称*/
	@Column(name="SUBJECT_NAME")
	private String subjectName;

	public TbSubject() {
	}

	public String getSubjectId() {
		return this.subjectId;
	}

	public void setSubjectId(String subjectId) {
		this.subjectId = subjectId;
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

	public Date getDeleteDate() {
		return this.deleteDate;
	}

	public void setDeleteDate(Date deleteDate) {
		this.deleteDate = deleteDate;
	}

	public Integer getIsOn() {
		return this.isOn;
	}

	public void setIsOn(Integer isOn) {
		this.isOn = isOn;
	}

	public Integer getIsOnTheory() {
		return this.isOnTheory;
	}

	public void setIsOnTheory(Integer isOnTheory) {
		this.isOnTheory = isOnTheory;
	}

	public Integer getIsOnroad() {
		return this.isOnroad;
	}

	public void setIsOnroad(Integer isOnroad) {
		this.isOnroad = isOnroad;
	}

	public String getLicenseType() {
		return this.licenseType;
	}

	public void setLicenseType(String licenseType) {
		this.licenseType = licenseType;
	}

	public String getLicenseTypeCode() {
		return this.licenseTypeCode;
	}

	public void setLicenseTypeCode(String licenseTypeCode) {
		this.licenseTypeCode = licenseTypeCode;
	}

	public String getSubjectAsname() {
		return this.subjectAsname;
	}

	public void setSubjectAsname(String subjectAsname) {
		this.subjectAsname = subjectAsname;
	}

	public String getSubjectCode() {
		return this.subjectCode;
	}

	public void setSubjectCode(String subjectCode) {
		this.subjectCode = subjectCode;
	}

	public Integer getSubjectGreate() {
		return this.subjectGreate;
	}

	public void setSubjectGreate(Integer subjectGreate) {
		this.subjectGreate = subjectGreate;
	}

	public String getSubjectInfo() {
		return this.subjectInfo;
	}

	public void setSubjectInfo(String subjectInfo) {
		this.subjectInfo = subjectInfo;
	}

	public String getSubjectName() {
		return this.subjectName;
	}

	public void setSubjectName(String subjectName) {
		this.subjectName = subjectName;
	}

}