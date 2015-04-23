package com.yuhui.core.entity.system;

import java.io.Serializable;

public class UserRole implements Serializable {

	/** */
	private static final long serialVersionUID = 1L;

	private String userId;
	private String roleId;
	
	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getRoleId() {
		return roleId;
	}

	public void setRoleId(String roleId) {
		this.roleId = roleId;
	}

	public UserRole() {
	}

	public UserRole(String userId, String roleId) {
		super();
		this.userId = userId;
		this.roleId = roleId;
	}

}
