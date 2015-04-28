package com.jiaxiao.entity;

import java.io.Serializable;
import javax.persistence.*;

/**
 * @author 肖长江
 * 字典信息
 */
@Entity
@Table(name="tb_sys_data")
public class TbSysData implements Serializable {
	private static final long serialVersionUID = 1L;

	/** 字典编号*/
	@Id
	@Column(name="DATA_ID")
	private String dataId;

	/** 备注*/
	private String common;

	/** 编码*/
	@Column(name="DATA_CODE")
	private String dataCode;

	/** 名称*/
	@Column(name="DATA_NAME")
	private String dataName;

	/** 父编号*/
	@Column(name="DATA_PID")
	private String dataPid;

	/** 序号*/
	@Column(name="DATA_XH")
	private Integer dataXh;

	public TbSysData() {
	}

	public String getDataId() {
		return this.dataId;
	}

	public void setDataId(String dataId) {
		this.dataId = dataId;
	}

	public String getCommon() {
		return this.common;
	}

	public void setCommon(String common) {
		this.common = common;
	}

	public String getDataCode() {
		return this.dataCode;
	}

	public void setDataCode(String dataCode) {
		this.dataCode = dataCode;
	}

	public String getDataName() {
		return this.dataName;
	}

	public void setDataName(String dataName) {
		this.dataName = dataName;
	}

	public String getDataPid() {
		return this.dataPid;
	}

	public void setDataPid(String dataPid) {
		this.dataPid = dataPid;
	}

	public Integer getDataXh() {
		return this.dataXh;
	}

	public void setDataXh(Integer dataXh) {
		this.dataXh = dataXh;
	}

}