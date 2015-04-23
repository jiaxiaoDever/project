package com.yuhui.core.entity.common;

import java.io.Serializable;

public class SqlFieldValueBean implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = -4128557070072263226L;
	private String field;
	private String mybatisField;
	private Object value;

	public SqlFieldValueBean() {
	}

	public SqlFieldValueBean(String field, Object value, String mybatisField) {
		this.field = field;
		this.value = value;
		this.mybatisField = mybatisField;
	}

	public SqlFieldValueBean(String field, Object value) {
		this.field = field;
		this.value = value;
	}

	public String getFields() {
		return field;
	}

	public void setFields(String field) {
		this.field = field;
	}

	public Object getValue() {
		return value;
	}

	public void setValue(Object value) {
		this.value = value;
	}

	public String getMybatisField() {
		return mybatisField;
	}

	public void setMybatisField(String mybatisField) {
		this.mybatisField = mybatisField;
	}

}
