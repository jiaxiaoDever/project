package com.yuhui.core.entity.common;

public class TextIdBean {

	private Long id;
	private String name;

	public TextIdBean() {
	}

	public TextIdBean(String name, Long id) {
		this.name = name;
		this.id = id;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

}
