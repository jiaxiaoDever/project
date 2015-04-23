package com.yuhui.core.entity.common;

import javax.persistence.Entity;
import javax.persistence.IdClass;
import javax.persistence.Table;

import com.yuhui.core.entity.base.IdEntity;
@Entity
@Table(name = "tb_sys_enum")
@IdClass(value=String.class)
public class SysEnum extends IdEntity{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1334718953438746872L;
	/**
	 * 
	 */
	private String tableName;
	private String fieldName;
	private String value;
	private String description;
	private int state;
	private int sort;
	private String code;

	public String getTableName() {
		return tableName;
	}

	public void setTableName(String tableName) {
		this.tableName = tableName;
	}

	public String getFieldName() {
		return fieldName;
	}

	public void setFieldName(String fieldName) {
		this.fieldName = fieldName;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public int getState() {
		return state;
	}

	public void setState(int state) {
		this.state = state;
	}

	public int getSort() {
		return sort;
	}

	public void setSort(int sort) {
		this.sort = sort;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

}
