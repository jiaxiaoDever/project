package com.jiaxiao.entity;

import java.io.Serializable;
import javax.persistence.*;
import java.util.Date;


/**
 * @author 肖长江
 * 消息模板换建信息
 */
@Entity
@Table(name="tb_key_tm")
public class TbKeyTm implements Serializable {
	private static final long serialVersionUID = 1L;

	/** 换键编号*/
	@Id
	@Column(name="TM_KEY_ID")
	private String tmKeyId;

	/** 创建时间*/
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="CREATE_DATE")
	private Date createDate;

	/** 默认值*/
	@Column(name="DEFUALT_VALUE")
	private String defualtValue;

	/** 编辑时间*/
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="EDIT_DATE")
	private Date editDate;

	/** 键码*/
	@Column(name="KEY_CODE")
	private String keyCode;

	/** 键描述*/
	@Column(name="KEY_INFO")
	private String keyInfo;

	/** 键要求*/
	@Column(name="KEY_REQUEST")
	private String keyRequest;

	/** 消息模板编号*/
	@Column(name="TM_ID")
	private String tmId;

	public TbKeyTm() {
	}

	public String getTmKeyId() {
		return this.tmKeyId;
	}

	public void setTmKeyId(String tmKeyId) {
		this.tmKeyId = tmKeyId;
	}

	public Date getCreateDate() {
		return this.createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public String getDefualtValue() {
		return this.defualtValue;
	}

	public void setDefualtValue(String defualtValue) {
		this.defualtValue = defualtValue;
	}

	public Date getEditDate() {
		return this.editDate;
	}

	public void setEditDate(Date editDate) {
		this.editDate = editDate;
	}

	public String getKeyCode() {
		return this.keyCode;
	}

	public void setKeyCode(String keyCode) {
		this.keyCode = keyCode;
	}

	public String getKeyInfo() {
		return this.keyInfo;
	}

	public void setKeyInfo(String keyInfo) {
		this.keyInfo = keyInfo;
	}

	public String getKeyRequest() {
		return this.keyRequest;
	}

	public void setKeyRequest(String keyRequest) {
		this.keyRequest = keyRequest;
	}

	public String getTmId() {
		return this.tmId;
	}

	public void setTmId(String tmId) {
		this.tmId = tmId;
	}

}