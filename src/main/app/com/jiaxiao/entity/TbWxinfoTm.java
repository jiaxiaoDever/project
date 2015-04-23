package com.jiaxiao.entity;

import java.io.Serializable;
import javax.persistence.*;
import java.util.Date;


/**
 * The persistent class for the tb_wxinfo_tm database table.
 * 
 */
@Entity
@Table(name="tb_wxinfo_tm")
public class TbWxinfoTm implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="TM_ID")
	private String tmId;

	private String common;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="CREATE_DATE")
	private Date createDate;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="EDIT_DATE")
	private Date editDate;

	@Column(name="INDUSTRY_ONE")
	private String industryOne;

	@Column(name="INDUSTRY_TWO")
	private String industryTwo;

	@Column(name="JX_PUBLIC_ID")
	private String jxPublicId;

	@Column(name="PUBLIC_ID")
	private String publicId;

	@Column(name="PUBLIC_TM_ID")
	private String publicTmId;

	@Column(name="TM_CODE")
	private String tmCode;

	@Column(name="TM_DATA")
	private String tmData;

	@Column(name="TM_INFO")
	private String tmInfo;

	@Column(name="TM_NAME")
	private String tmName;

	@Column(name="TM_TYPE")
	private String tmType;

	@Column(name="TM_TYPE_CODE")
	private String tmTypeCode;

	@Column(name="WXTM_ID")
	private String wxtmId;

	public TbWxinfoTm() {
	}

	public String getTmId() {
		return this.tmId;
	}

	public void setTmId(String tmId) {
		this.tmId = tmId;
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

	public String getIndustryOne() {
		return this.industryOne;
	}

	public void setIndustryOne(String industryOne) {
		this.industryOne = industryOne;
	}

	public String getIndustryTwo() {
		return this.industryTwo;
	}

	public void setIndustryTwo(String industryTwo) {
		this.industryTwo = industryTwo;
	}

	public String getJxPublicId() {
		return this.jxPublicId;
	}

	public void setJxPublicId(String jxPublicId) {
		this.jxPublicId = jxPublicId;
	}

	public String getPublicId() {
		return this.publicId;
	}

	public void setPublicId(String publicId) {
		this.publicId = publicId;
	}

	public String getPublicTmId() {
		return this.publicTmId;
	}

	public void setPublicTmId(String publicTmId) {
		this.publicTmId = publicTmId;
	}

	public String getTmCode() {
		return this.tmCode;
	}

	public void setTmCode(String tmCode) {
		this.tmCode = tmCode;
	}

	public String getTmData() {
		return this.tmData;
	}

	public void setTmData(String tmData) {
		this.tmData = tmData;
	}

	public String getTmInfo() {
		return this.tmInfo;
	}

	public void setTmInfo(String tmInfo) {
		this.tmInfo = tmInfo;
	}

	public String getTmName() {
		return this.tmName;
	}

	public void setTmName(String tmName) {
		this.tmName = tmName;
	}

	public String getTmType() {
		return this.tmType;
	}

	public void setTmType(String tmType) {
		this.tmType = tmType;
	}

	public String getTmTypeCode() {
		return this.tmTypeCode;
	}

	public void setTmTypeCode(String tmTypeCode) {
		this.tmTypeCode = tmTypeCode;
	}

	public String getWxtmId() {
		return this.wxtmId;
	}

	public void setWxtmId(String wxtmId) {
		this.wxtmId = wxtmId;
	}

}