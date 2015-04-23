package com.jiaxiao.entity;

import java.io.Serializable;
import javax.persistence.*;
import java.util.Date;


/**
 * The persistent class for the tb_subject database table.
 * 
 */
@Entity
@Table(name="tb_subject")
public class TbSubject implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="SUBJECT_ID")
	private String subjectId;

	private String common;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="CREATE_DATE")
	private Date createDate;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="DELETE_DATE")
	private Date deleteDate;

	@Column(name="IS_ON")
	private Integer isOn;

	@Column(name="IS_ON_THEORY")
	private Integer isOnTheory;

	@Column(name="IS_ONROAD")
	private Integer isOnroad;

	@Column(name="LICENSE_TYPE")
	private String licenseType;

	@Column(name="LICENSE_TYPE_CODE")
	private String licenseTypeCode;

	@Column(name="SUBJECT_ASNAME")
	private String subjectAsname;

	@Column(name="SUBJECT_CODE")
	private String subjectCode;

	@Column(name="SUBJECT_GREATE")
	private Integer subjectGreate;

	@Column(name="SUBJECT_INFO")
	private String subjectInfo;

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