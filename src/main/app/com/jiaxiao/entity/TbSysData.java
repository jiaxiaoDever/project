package com.jiaxiao.entity;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the tb_sys_data database table.
 * 
 */
@Entity
@Table(name="tb_sys_data")
public class TbSysData implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="DATA_ID")
	private String dataId;

	private String common;

	@Column(name="DATA_CODE")
	private String dataCode;

	@Column(name="DATA_NAME")
	private String dataName;

	@Column(name="DATA_PID")
	private String dataPid;

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