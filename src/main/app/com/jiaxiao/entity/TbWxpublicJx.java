package com.jiaxiao.entity;

import java.io.Serializable;
import javax.persistence.*;
import java.util.Date;


/**
 * The persistent class for the tb_wxpublic_jx database table.
 * 
 */
@Entity
@Table(name="tb_wxpublic_jx")
public class TbWxpublicJx implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="JX_PUBLIC_ID")
	private String jxPublicId;

	private String common;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="CREATE_DATE")
	private Date createDate;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="DOWN_DATE")
	private Date downDate;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="DOWN_INFO")
	private Date downInfo;

	@Column(name="JX_ID")
	private String jxId;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="ONLINE_DATE")
	private Date onlineDate;

	@Column(name="PUBLIC_ID")
	private String publicId;

	@Column(name="PUBLIC_INFO")
	private String publicInfo;

	@Column(name="PUBLIC_NAME")
	private String publicName;

	@Column(name="PUBLIC_SECRET")
	private String publicSecret;

	@Column(name="PUBLIC_STAT")
	private String publicStat;

	@Column(name="PUBLIC_STAT_CODE")
	private String publicStatCode;

	@Column(name="PUBLIC_TYPE")
	private String publicType;

	@Column(name="PUBLIC_TYPE_CODE")
	private String publicTypeCode;

	@Column(name="QR_INFO_URL")
	private String qrInfoUrl;

	@Column(name="QR_SCENE_STR")
	private String qrSceneStr;

	@Column(name="QR_TICKET")
	private String qrTicket;

	@Column(name="QR_URL")
	private String qrUrl;

	@Column(name="REG_EMAIL")
	private String regEmail;

	public TbWxpublicJx() {
	}

	public String getJxPublicId() {
		return this.jxPublicId;
	}

	public void setJxPublicId(String jxPublicId) {
		this.jxPublicId = jxPublicId;
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

	public Date getDownDate() {
		return this.downDate;
	}

	public void setDownDate(Date downDate) {
		this.downDate = downDate;
	}

	public Date getDownInfo() {
		return this.downInfo;
	}

	public void setDownInfo(Date downInfo) {
		this.downInfo = downInfo;
	}

	public String getJxId() {
		return this.jxId;
	}

	public void setJxId(String jxId) {
		this.jxId = jxId;
	}

	public Date getOnlineDate() {
		return this.onlineDate;
	}

	public void setOnlineDate(Date onlineDate) {
		this.onlineDate = onlineDate;
	}

	public String getPublicId() {
		return this.publicId;
	}

	public void setPublicId(String publicId) {
		this.publicId = publicId;
	}

	public String getPublicInfo() {
		return this.publicInfo;
	}

	public void setPublicInfo(String publicInfo) {
		this.publicInfo = publicInfo;
	}

	public String getPublicName() {
		return this.publicName;
	}

	public void setPublicName(String publicName) {
		this.publicName = publicName;
	}

	public String getPublicSecret() {
		return this.publicSecret;
	}

	public void setPublicSecret(String publicSecret) {
		this.publicSecret = publicSecret;
	}

	public String getPublicStat() {
		return this.publicStat;
	}

	public void setPublicStat(String publicStat) {
		this.publicStat = publicStat;
	}

	public String getPublicStatCode() {
		return this.publicStatCode;
	}

	public void setPublicStatCode(String publicStatCode) {
		this.publicStatCode = publicStatCode;
	}

	public String getPublicType() {
		return this.publicType;
	}

	public void setPublicType(String publicType) {
		this.publicType = publicType;
	}

	public String getPublicTypeCode() {
		return this.publicTypeCode;
	}

	public void setPublicTypeCode(String publicTypeCode) {
		this.publicTypeCode = publicTypeCode;
	}

	public String getQrInfoUrl() {
		return this.qrInfoUrl;
	}

	public void setQrInfoUrl(String qrInfoUrl) {
		this.qrInfoUrl = qrInfoUrl;
	}

	public String getQrSceneStr() {
		return this.qrSceneStr;
	}

	public void setQrSceneStr(String qrSceneStr) {
		this.qrSceneStr = qrSceneStr;
	}

	public String getQrTicket() {
		return this.qrTicket;
	}

	public void setQrTicket(String qrTicket) {
		this.qrTicket = qrTicket;
	}

	public String getQrUrl() {
		return this.qrUrl;
	}

	public void setQrUrl(String qrUrl) {
		this.qrUrl = qrUrl;
	}

	public String getRegEmail() {
		return this.regEmail;
	}

	public void setRegEmail(String regEmail) {
		this.regEmail = regEmail;
	}

}