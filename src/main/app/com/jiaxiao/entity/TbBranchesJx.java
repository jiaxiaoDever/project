package com.jiaxiao.entity;

import java.io.Serializable;
import javax.persistence.*;
import java.util.Date;


/**
 * @author 肖长江
 * 驾校网点信息
 */
@Entity
@Table(name="tb_branches_jx")
public class TbBranchesJx implements Serializable {
	private static final long serialVersionUID = 1L;

	/** 网点编号*/
	@Id
	@Column(name="BRANCH_ID")
	private String branchId;

	/** 网点地址*/
	@Column(name="BRANCH_ADDRESS")
	private String branchAddress;

	/** 所在区县*/
	@Column(name="BRANCH_AREA")
	private String branchArea;

	/** 班车信息*/
	@Column(name="BRANCH_BUS")
	private String branchBus;

	/** 所在城市*/
	@Column(name="BRANCH_CITY")
	private String branchCity;

	/** 名称*/
	@Column(name="BRANCH_NAME")
	private String branchName;

	/** 所在省份*/
	@Column(name="BRANCH_PROVICE")
	private String branchProvice;

	/** 简写名称*/
	@Column(name="BRANCH_SHORT_NAME")
	private String branchShortName;

	/** 状态*/
	@Column(name="BRANCH_STAT")
	private String branchStat;

	/** 状态编码*/
	@Column(name="BRANCH_STAT_CODE")
	private String branchStatCode;

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

	/** 编辑时间*/
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="EDIT_DATE")
	private Date editDate;

	/** 驾校编号*/
	@Column(name="JX_ID")
	private String jxId;

	/** 驾校名称*/
	@Column(name="JX_NAME")
	private String jxName;

	/** 维护结束时间*/
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="STOP_END_DATE")
	private Date stopEndDate;

	/** 维护开始时间*/
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="STOP_START_DATE")
	private Date stopStartDate;

	public TbBranchesJx() {
	}

	public String getBranchId() {
		return this.branchId;
	}

	public void setBranchId(String branchId) {
		this.branchId = branchId;
	}

	public String getBranchAddress() {
		return this.branchAddress;
	}

	public void setBranchAddress(String branchAddress) {
		this.branchAddress = branchAddress;
	}

	public String getBranchArea() {
		return this.branchArea;
	}

	public void setBranchArea(String branchArea) {
		this.branchArea = branchArea;
	}

	public String getBranchBus() {
		return this.branchBus;
	}

	public void setBranchBus(String branchBus) {
		this.branchBus = branchBus;
	}

	public String getBranchCity() {
		return this.branchCity;
	}

	public void setBranchCity(String branchCity) {
		this.branchCity = branchCity;
	}

	public String getBranchName() {
		return this.branchName;
	}

	public void setBranchName(String branchName) {
		this.branchName = branchName;
	}

	public String getBranchProvice() {
		return this.branchProvice;
	}

	public void setBranchProvice(String branchProvice) {
		this.branchProvice = branchProvice;
	}

	public String getBranchShortName() {
		return this.branchShortName;
	}

	public void setBranchShortName(String branchShortName) {
		this.branchShortName = branchShortName;
	}

	public String getBranchStat() {
		return this.branchStat;
	}

	public void setBranchStat(String branchStat) {
		this.branchStat = branchStat;
	}

	public String getBranchStatCode() {
		return this.branchStatCode;
	}

	public void setBranchStatCode(String branchStatCode) {
		this.branchStatCode = branchStatCode;
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

	public Date getEditDate() {
		return this.editDate;
	}

	public void setEditDate(Date editDate) {
		this.editDate = editDate;
	}

	public String getJxId() {
		return this.jxId;
	}

	public void setJxId(String jxId) {
		this.jxId = jxId;
	}

	public String getJxName() {
		return this.jxName;
	}

	public void setJxName(String jxName) {
		this.jxName = jxName;
	}

	public Date getStopEndDate() {
		return this.stopEndDate;
	}

	public void setStopEndDate(Date stopEndDate) {
		this.stopEndDate = stopEndDate;
	}

	public Date getStopStartDate() {
		return this.stopStartDate;
	}

	public void setStopStartDate(Date stopStartDate) {
		this.stopStartDate = stopStartDate;
	}

	public TbBranchesJx(String branchId, String branchAddress,
			String branchArea, String branchBus, String branchCity,
			String branchName, String branchProvice, String branchShortName,
			String branchStat, String branchStatCode, String common,
			Date createDate, Date deleteDate, Date editDate, String jxId,
			String jxName, Date stopEndDate, Date stopStartDate) {
		super();
		this.branchId = branchId;
		this.branchAddress = branchAddress;
		this.branchArea = branchArea;
		this.branchBus = branchBus;
		this.branchCity = branchCity;
		this.branchName = branchName;
		this.branchProvice = branchProvice;
		this.branchShortName = branchShortName;
		this.branchStat = branchStat;
		this.branchStatCode = branchStatCode;
		this.common = common;
		this.createDate = createDate;
		this.deleteDate = deleteDate;
		this.editDate = editDate;
		this.jxId = jxId;
		this.jxName = jxName;
		this.stopEndDate = stopEndDate;
		this.stopStartDate = stopStartDate;
	}

}