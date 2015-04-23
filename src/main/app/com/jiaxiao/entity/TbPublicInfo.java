package com.jiaxiao.entity;

import java.io.Serializable;
import javax.persistence.*;
import java.util.Date;


/**
 * The persistent class for the tb_public_info database table.
 * 
 */
@Entity
@Table(name="tb_public_info")
public class TbPublicInfo implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="PUBLIC_INFO_ID")
	private String publicInfoId;

	private String commom;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="CREATE_DATE")
	private Date createDate;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="EDIT_DATE")
	private Date editDate;

	@Column(name="INFO_DATA")
	private String infoData;

	@Column(name="INFO_URL")
	private String infoUrl;

	@Column(name="MAX_SEND_NUM")
	private Integer maxSendNum;

	@Column(name="OPEN_ID")
	private String openId;

	@Column(name="OPEN_ZH")
	private String openZh;

	@Column(name="SEND_NUM")
	private Integer sendNum;

	@Column(name="SEND_RETURN")
	private String sendReturn;

	@Column(name="SEND_STAT")
	private String sendStat;

	@Column(name="SEND_STAT_CODE")
	private String sendStatCode;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="SEND_TIME")
	private Date sendTime;

	@Column(name="TM_ID")
	private String tmId;

	public TbPublicInfo() {
	}

	public String getPublicInfoId() {
		return this.publicInfoId;
	}

	public void setPublicInfoId(String publicInfoId) {
		this.publicInfoId = publicInfoId;
	}

	public String getCommom() {
		return this.commom;
	}

	public void setCommom(String commom) {
		this.commom = commom;
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

	public String getInfoData() {
		return this.infoData;
	}

	public void setInfoData(String infoData) {
		this.infoData = infoData;
	}

	public String getInfoUrl() {
		return this.infoUrl;
	}

	public void setInfoUrl(String infoUrl) {
		this.infoUrl = infoUrl;
	}

	public Integer getMaxSendNum() {
		return this.maxSendNum;
	}

	public void setMaxSendNum(Integer maxSendNum) {
		this.maxSendNum = maxSendNum;
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

	public Integer getSendNum() {
		return this.sendNum;
	}

	public void setSendNum(Integer sendNum) {
		this.sendNum = sendNum;
	}

	public String getSendReturn() {
		return this.sendReturn;
	}

	public void setSendReturn(String sendReturn) {
		this.sendReturn = sendReturn;
	}

	public String getSendStat() {
		return this.sendStat;
	}

	public void setSendStat(String sendStat) {
		this.sendStat = sendStat;
	}

	public String getSendStatCode() {
		return this.sendStatCode;
	}

	public void setSendStatCode(String sendStatCode) {
		this.sendStatCode = sendStatCode;
	}

	public Date getSendTime() {
		return this.sendTime;
	}

	public void setSendTime(Date sendTime) {
		this.sendTime = sendTime;
	}

	public String getTmId() {
		return this.tmId;
	}

	public void setTmId(String tmId) {
		this.tmId = tmId;
	}

}