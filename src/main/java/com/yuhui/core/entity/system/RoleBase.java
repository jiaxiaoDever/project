package com.yuhui.core.entity.system;


import javax.persistence.Entity;
import javax.persistence.Table;

import com.yuhui.core.entity.base.StatefulEntity;

/** 角色 */
@Entity
@Table(name = "tb_sys_role")
public class RoleBase extends StatefulEntity {

	private static final long serialVersionUID = 1L;

	/** 岗位名称 */
	private String name;

	/** 角色标记,给程序判断角色使用 */
	private String symbol;

	
	/** 角色等级 */
	private Integer roleLevel;
	
	/** 描述 */
	private String description;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getSymbol() {
		return symbol;
	}

	public void setSymbol(String symbol) {
		this.symbol = symbol;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Integer getRoleLevel() {
		return roleLevel;
	}

	public void setRoleLevel(Integer roleLevel) {
		this.roleLevel = roleLevel;
	}

}
